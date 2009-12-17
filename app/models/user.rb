class User < ActiveRecord::Base
  include GoogleBehaviour

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
    (Hpricot(feed.body) / "entry").map do |entry|
      {
        :url => (entry / "content[@type=application/atom+xml]").first.attributes['src'],
        :name => (entry / "title").first
      }
    end
  end

end
