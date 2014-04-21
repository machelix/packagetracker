class Emailer < ActionMailer::Base
  default :from => "rails.action.mailer@gmail.com"

  def welcome_email(email_address)
    mail(:to => email_address, :subject => 'Welcome to PackageTracker')
  end

  def packages_notification(current_time,packages,recipients)

    @recipients = recipients
    @packages = packages
    @current_time = current_time

    mail(:cc => @recipients, :subject => 'Packages to be delivered')
  end
end
