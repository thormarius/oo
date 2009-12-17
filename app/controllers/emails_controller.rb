class EmailsController < ApplicationController
  before_filter :login_required

  def index
    headers["Content-Type"] = "text/plain"
    render :text => current_user.emails
  end

#  def show
#    # Enkelt mail
#  end
end
