require 'rexml/document'

class EmailsController < ApplicationController
  before_filter :login_required

  def index
    REXML::Document.new(current_user.emails).write(@emails_atom="", 2)
  end

#  def show
#    # Enkelt mail
#  end
end
