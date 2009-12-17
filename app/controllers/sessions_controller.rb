class SessionsController < ApplicationController
  include OpenidConstants

  def new; end

  def create
    open_id_authentication
  end

  def destroy
    current_user.reset_secrets
    reset_session
    redirect_back_or_default('/')
  end


  protected

  def open_id_authentication
    authenticate_with_open_id(IDENTITY_URL, OPENID_OPTS) do |openid_result, identity_url, registration|
      if openid_result.successful?
        self.current_user = User.register(registration,  identity_url)
        redirect_to authenticated_content_url
      else
        render :text => "OpenID authentication failed"
      end
    end
  end


end
