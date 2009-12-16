class SessionsController < ApplicationController
  #include OauthConstants
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


  # def failed_login(message = "Autentiseringen feilet.")
  #   flash[:error] = message
  #   redirect_to root_path
  #  end

  # def successful_login
  #   redirect_back_or_default(intranett_main_path)
  # end

  private
  def set_user(registration, identity_url)
    user = User.find_or_initialize_by_identity_url(identity_url)
    user.first_name = registration[OPENID_FIRST].first
    user.last_name = registration[OPENID_LAST].first
    user.email = registration[OPENID_EMAIL].first
    user.language = registration[OPENID_LANGUAGE].first
    user.save!
    self.current_user = user
  end
end
