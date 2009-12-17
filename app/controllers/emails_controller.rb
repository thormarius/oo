require 'rexml/document'

class EmailsController < ApplicationController
  before_filter :login_required

  def index
    @emails_atom = REXML::Document.new(current_user.emails).to_s(2)
  end

#  def show
#    # Enkelt mail
#  end
end
