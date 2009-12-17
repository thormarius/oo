require 'rexml/document'

class EmailsController < ApplicationController
  before_filter :login_required

  def index
    begin
      REXML::Document.new(current_user.emails).write(@emails_atom="", 2)
    rescue
      @emails_atom = current_user.emails
    end
  end
end
