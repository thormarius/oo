class CalendarsController < ApplicationController
  before_filter :login_required

  # /calendars
  def index
  end

  # /calendars/<id>
  def show
    # Atom for en kalender - flere events
  end
end

