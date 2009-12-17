class User < ActiveRecord::Base
  include GoogleBehaviour

  def emails
    email_feed.body
  end
  
  def calendars
    calendars_feed.body
  end

  def events(calendar)
    event_feed(calendar).body
  end

end
