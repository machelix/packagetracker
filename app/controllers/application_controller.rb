class ApplicationController < ActionController::Base
  include PackageHelper
  include EmailHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :exception
  http_basic_authenticate_with :name => "admin", :password => "alphabetagamma"


  def notify_couriers
    @current_time = Time.now

    @packages = find_packages(application_params[:city_db_id])

    @emails = find_emails(application_params[:city_db_id])

    ## Create list of recipients as array of strings
    @recipients = []
    @emails.each do |email|
      @recipients << email.email_value
    end

    # Tell the Emailer to send a notification email to all couriers
    Emailer.packages_notification(@current_time,@packages,@recipients).deliver
  end

  private
  def application_params
    params.require(:application).permit(:city_db_id)
  end
end
