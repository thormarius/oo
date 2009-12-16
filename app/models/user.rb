class User < ActiveRecord::Base
  include GoogleBehaviour

  def mail
    email_feed.body
  end
  
  def calendars
     calendars_feed.body
  end
end
