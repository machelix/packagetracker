class NotifyCouriersJob < Struct.new(:city_db_id)
  def perform
    current_time = Time.now
    packages = find_packages(city_db_id)
    #puts "Current Time: #{current_time}"
    #puts "Packages available for city code: #{city_db_id}"
    #puts packages.inspect
    emails = find_emails(city_db_id)
    Emailer.packages_notification(current_time,packages,emails).deliver
  end
end