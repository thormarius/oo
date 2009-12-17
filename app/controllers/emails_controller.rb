class EmailsController < ApplicationController
  before_filter :login_required

  def index
    begin
      @emails_atom = Nokogiri::XML(current_user.emails).to_s
    rescue => e
      Rails.logger.info("Got exception: #{e.inspect}")
      @emails_atom = current_user.emails
    end
  end
end
