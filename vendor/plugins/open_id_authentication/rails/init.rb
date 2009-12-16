OpenID::Util.logger = Rails.logger
ActionController::Base.send :include, OpenIdAuthentication
