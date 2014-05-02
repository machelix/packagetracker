require 'clockwork'
require 'notify_couriers_job'

class ApplicationController < ActionController::Base
  include PackageHelper
  include EmailHelper
  include Clockwork
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :exception
  http_basic_authenticate_with :name => "admin", :password => "alphabetagamma"

  # Runs a notify couriers action for application : send out emails to registered couriers with package details
  # Params: city db id for application controller
  # - command :: command line string to be executed by the system
  # - outhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # - errhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def notify_couriers
    @current_time = Time.zone.now

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

  # Runs a notify couriers action for application at specific time : send out emails to registered couriers with package details
  # Params: city db id & schedule times for dispatcher
  # - command :: command line string to be executed by the system
  # - outhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # - errhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def scheduled_notification
    @scheduled_time =  params[:time]
    @city_db_id =  application_params[:city_db_id]

    @scheduled_time.each do |time|
      Delayed::Job.enqueue(NotifyCouriersJob.new(@city_db_id), :run_at => time)
    end
  end

  private
  # Private method available to application controller methods : used for strongly checking paramaters to various actions inside controller
  # Params: permitted city db id for application controller
  # - command :: command line string to be executed by the system
  # - outhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # - errhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def application_params
    params.require(:application).permit(:city_db_id)
  end
end
