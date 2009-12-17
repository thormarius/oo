class User < ActiveRecord::Base
  include OpenidConstants

  def emails
    email_feed.body
  end
  
  def calendars
    calendars_feed.body
  end

  def events(url)
    event_feed(url).body
  end

  def calendar_links
    feed = calendars_feed
    return [] unless Net::HTTPOK === feed
    links = (Hpricot(feed.body) / "entry").map do |entry|
      {
        :url => (entry / "content[@type=application/atom+xml]").first.attributes['src'],
        :name => (entry / "title").text
      }
    end
    Rails.logger.info("Calendar links: #{links}")
    links
  end

  def self.register(registration, identity_url)
    user = find_or_initialize_by_identity_url(identity_url)
    user.first_name = registration[OPENID_FIRST].first
    user.last_name = registration[OPENID_LAST].first
    user.email = registration[OPENID_EMAIL].first
    user.language = registration[OPENID_LANGUAGE].first
    if Rails.env == "production"
      consumer = OAuth::Consumer.new(OAUTH_CONSUMER_TOKEN, OAUTH_CONSUMER_SECRET, GOOGLE_SETTINGS)
      request_token = OAuth::RequestToken.new(consumer, registration[:request_token], "")
      oauth_access_token = request_token.get_access_token
      user.oauth_token = oauth_access_token.token
      user.oauth_secret = oauth_access_token.secret
    end
    user.save!
  end

  def reset_secrets
    self.oauth_secret = nil
    self.oauth_token  = nil
    save!
  end

  private
  def calendars_feed
    @calendars ||= calendars_feed_with_redirect
  end


  def event_feed(url)
    event_feed = access_token.get(url)
    if Net::HTTPFound === event_feed
      event_feed = access_token.get(event_feed['location'])
    end
    event_feed
  end

  def email_feed
    @email_feed ||= access_token.get(MAIL_FEED)
  end


  def access_token
    return @access_token if @access_token
    consumer      = OAuth::Consumer.new(OAUTH_CONSUMER_TOKEN, OAUTH_CONSUMER_SECRET, GOOGLE_SETTINGS)
    @access_token = OAuth::AccessToken.new(consumer, oauth_token, oauth_secret)
  end

  def calendars_feed_with_redirect
    calendars = access_token.get(CALENDARS_FEED)
    if Net::HTTPFound === calendars
      calendars = access_token.get(calendars['location'])
    end
    calendars
  end

end
