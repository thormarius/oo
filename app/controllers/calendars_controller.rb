class CalendarsController < ApplicationController
  before_filter :login_required

  def index
    REXML::Document.new(current_user.calendars).write(@calendars_atom="", 2)
  end

  # /calendars/<id>
  def show
    # Atom for en kalender - flere events
  end
end

