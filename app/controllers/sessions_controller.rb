class SessionsController < ApplicationController
  include OauthConstants
  include OpenidConstants

  def new; end

  def create
    open_id_authentication
  end

  def destroy
    reset_session
    redirect_back_or_default('/')
  end


  protected

  def open_id_authentication
    authenticate_with_open_id(IDENTITY_URL, OPENID_OPTS) do |openid_result, identity_url, registration|
      if openid_result.successful?
        set_user(registration, identity_url)
        redirect_to authenticated_content_url
      else
        render :text => "OpenID authentication failed"
      end
    end
  end



  private
  def set_user(registration, identity_url)
    Rails.logger.info "************** SECRET **************************"
    Rails.logger.info OAUTH_CONSUMER_SECRET
    Rails.logger.info "****************************************"
    user = User.find_or_initialize_by_identity_url(identity_url)
    user.first_name = registration[OPENID_FIRST].first
    user.last_name = registration[OPENID_LAST].first
    user.email = registration[OPENID_EMAIL].first
    user.language = registration[OPENID_LANGUAGE].first
    if Rails.env == "production"
      consumer = OAuth::Consumer.new(OAUTH_CONSUMER_TOKEN, OAUTH_CONSUMER_SECRET, GOOGLE_SETTINGS)
      request_token = OAuth::RequestToken.new(consumer, registration[:request_token], "")
      Rails.logger.info "****************VERIFIER params #{params[:oauth_verifier]}********************"
      Rails.logger.info "****************VERIFIER registration #{registration[:oauth_verifier]}********************"
      oauth_access_token = request_token.get_access_token({:oauth_verifier => params[:oauth_verifier]})
      user.oauth_access_token = oauth_access_token.token
      user.oauth_access_secret = oauth_access_token.secret
    end

    user.save!
    self.current_user = user
  end
end
