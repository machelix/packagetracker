class NotifyCouriersJob < Struct.new(:city_db_id)
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