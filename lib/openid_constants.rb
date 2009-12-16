module OpenidConstants
  #include OauthConstants


  IDENTITY_URL = "https://www.google.com/accounts/o8/id"

  OPENID_EMAIL    = "http://axschema.org/contact/email"
  OPENID_FIRST    = "http://axschema.org/namePerson/first"
  OPENID_LAST     = "http://axschema.org/namePerson/last"
  OPENID_COUNTRY  = "http://axschema.org/contact/country/home"
  OPENID_LANGUAGE = "http://axschema.org/pref/language"
  

  OPENID_OPTS = {
    :required => [ OPENID_EMAIL, OPENID_FIRST, OPENID_LAST, OPENID_COUNTRY, OPENID_LANGUAGE ],
    #:oauth => OAUTH_OPTS
  }

  end