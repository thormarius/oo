class CalendarsController < ApplicationController
  before_filter :login_required

  def index
    @calendars = []
    begin
      @calendars_atom = Nokogiri::XML(current_user.calendars).to_s
    rescue => e
      Rails.logger.info("Got exception: #{e.inspect}")
      @calendars_atom = current_user.calendars
    end
  end

  # /calendars/<id>
  def show
    @events_atom = Nokogiri::XML(current_user.events(params[:id])).to_s
  end
end

