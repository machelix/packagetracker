require "#{Rails.root}/app/helpers/package_helper"
require "#{Rails.root}/app/helpers/email_helper"
include PackageHelper
include EmailHelper

# scheduler.rake
namespace :Scheduler do
  desc "Scheduled task for city A"
  task :SendEmailsA do |t, args|
    current_time = Time.now
    packages = find_packages(ENV['CITY_A'])
    #puts "Current Time: #{current_time}"
    #puts "Packages available for city code: #{ENV['CITY_A']}"
    #puts packages.inspect

    emails = find_emails(ENV['CITY_A'])
    #puts "Emails available for city code: #{ENV['CITY_A']}"
    #puts emails.inspect

    Emailer.packages_notification(current_time,packages,emails).deliver
  end

  desc "Scheduled task for city B"
  task :SendEmailsB do |t, args|
    current_time = Time.now
    packages = find_packages(ENV['CITY_B'])
    #puts "Current Time: #{current_time}"
    #puts "Packages available for city code: #{ENV['CITY_B']}"
    #puts packages.inspect

    emails = find_emails(ENV['CITY_B'])
    #puts "Emails available for city code: #{ENV['CITY_B']}"
    #puts emails.inspect
    Emailer.packages_notification(current_time,packages,emails).deliver
  end
end


desc "This task is called by the Heroku scheduler add-on"
task :send_notifications => :environment do
  puts "this test is working correctly!"
end