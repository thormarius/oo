module GoogleBehaviour
  include OauthConstants
  
  private
  def fetch_events
    feed = calendars_feed
    return nil unless Net::HTTPOK === feed
    threads = (Hpricot(feed.body) / "entry").map do |entry|
      hidden   = (entry / "gcal:hidden").first.attributes["value"]  == "true"
      selected = (entry / "gcal:selected").first.attributes["value"] == "true"
      if !hidden && selected
        url = (entry / "content[@type=application/atom+xml]").first.attributes['src']
        Thread.new do
          Thread.current[:events] = calendar_events("#{url}?#{CALENDAR_SETTINGS.to_param}")
        end
      end
    end.compact

    events = threads.map do |t|
      t.join
      t[:events]
    end

    events.flatten.sort do |a, b|
      a[:start] <=> b[:start]
    end[0,5]
  end

  def calendars_feed
    calendars = access_token.get(CALENDARS_FEED)
    if Net::HTTPFound === calendars
      calendars = access_token.get(calendars['location'])
    end
    calendars
  end

  def calendar_events(url)
    feed = event_feed(url)
    return nil unless Net::HTTPOK === feed
    doc = Hpricot(feed.body)
    title = doc.at("/feed/title").inner_text
    (doc / "entry").map do |entry|
      {
        :title    => (entry/"title").text,
        :where    => (entry/"gd:where").first.attributes['valuestring'],
        :start    => google_time((entry/"gd:when").first.attributes['starttime']),
        :end      => google_time((entry/"gd:when").first.attributes['endtime']),
        :href     => (entry/"link[@rel='alternate'][@type='text/html']").first.attributes['href'],
        :calendar => title
      }
    end
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
    @access_token = OAuth::AccessToken.new(consumer, oauth_access_token, oauth_access_secret)
  end

  def google_time(time)
    begin
      return Time.parse(time)
    rescue
      # Could be because google delivers hour as 24+.
      # Attempting to modify hour
      time =~/.*T(.*):.*:.*/
      begin
        hour = $1.to_i if $1
        if hour && hour > 23
          return Time.parse(time.gsub(/T\d+:/,  "T#{hour % 24}:"))
        end
      rescue
        Rails.logger.info("Could not parse date: #{time}")
      end
    end
  end
  nil
end
