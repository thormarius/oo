class EmailsController < ApplicationController
  before_filter :login_required

  def index
    render :text => current_user.emails
  end

#  def show
#    # Enkelt mail
#  end
end
