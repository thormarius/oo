class AuthenticatedController < ApplicationController
  before_filter :login_required

  def index
  end
end
