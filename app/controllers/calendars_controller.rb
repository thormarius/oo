require 'rexml/document'

class CalendarsController < ApplicationController
  before_filter :login_required

  def index
    begin
      @calendars_atom = Nokogiri::XML(current_user.calendars).to_s
    rescue => e
      @error = e.message
      @calendars_atom = current_user.calendars
    end
  end

  # /calendars/<id>
  def show
    # Atom for en kalender - flere events
  end
end

