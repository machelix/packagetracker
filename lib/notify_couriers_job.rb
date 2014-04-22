class NotifyCouriersJob < Struct.new(:city_db_id)
  # Job to fetch packages from city and send emails to registered couriers from the same city
  # Params: city db id for the city
  # Return: email sent to registered couriers
  # - command :: command line string to be executed by the system
  # - outhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # - errhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def perform
    current_time = Time.now
    packages = find_packages(city_db_id)
    emails = find_emails(city_db_id)

    ## Create list of recipients as array of strings
    recipients = []
    emails.each do |email|
      recipients << email.email_value
    end

    Emailer.packages_notification(current_time,packages,recipients).deliver
  end
end