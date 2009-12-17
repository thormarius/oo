class User < ActiveRecord::Base
  include GoogleBehaviour

  def emails
    email_feed.body
  end
  
  def calendars
    calendars_feed.body
  end
end
