module GoogleBehaviour
  include OauthConstants
  
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