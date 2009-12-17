class CalendarsController < ApplicationController
  before_filter :login_required

  def index
    begin
      REXML::Document.new(current_user.emails).write(@calendars_atom="", 2)
    rescue
      @calendars_atom = current_user.emails
    end
  end

  # /calendars/<id>
  def show
    # Atom for en kalender - flere events
  end
end

