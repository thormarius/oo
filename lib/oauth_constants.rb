require 'oauth'
require 'oauth/consumer'
require 'oauth/signature/rsa/sha1'

module OauthConstants

  OAUTH_CONSUMER_TOKEN  = "oo-demo.heroku.com"
  OAUTH_CONSUMER_SECRET = ENV["OAUTH_CONSUMER_SECRET"]


  MAIL_SCOPE            = "https://mail.google.com/mail/feed/atom/"
  CALENDAR_SCOPE        = "http://www.google.com/calendar/feeds/"

 
  
  CALENDAR_SETTINGS     = {
    'futureevents' => true,
    'orderby' => "starttime",
    'sortorder' => "a",
    'max-results' => 5,
    'singleevents' => true
  }



  GOOGLE_SETTINGS = {
    :site               => "https://www.google.com", 
    :request_token_path => "/accounts/OAuthGetRequestToken",
    :authorize_path     => "/accounts/OAuthAuthorizeToken",
    :access_token_path  => "/accounts/OAuthGetAccessToken"
  }

  OAUTH_OPTS = {
    :consumer => OAUTH_CONSUMER_TOKEN,
    :scope => [MAIL_SCOPE, CALENDAR_SCOPE].join(" ")
  }

  MAIL_FEED             = MAIL_SCOPE
  CALENDARS_FEED        = "#{CALENDAR_SCOPE}default/allcalendars/full"
  
end