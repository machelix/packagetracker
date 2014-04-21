class ApplicationController < ActionController::Base
  include EmailHelper
  include PackageHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :exception
  http_basic_authenticate_with :name => "admin", :password => "alphabetagamma"

  def notify_couriers
    @current_time = Time.now

    @packages = find_packages(params[:city_db_id])

    @emails = find_emails(params[:city_db_id])

    # Tell the Emailer to send a notification email to all couriers
    Emailer.packages_notification(@current_time,@packages,@emails).deliver
  end
end
