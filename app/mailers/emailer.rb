class Emailer < ActionMailer::Base
  default :from => "rails.action.mailer@gmail.com"

  # send welcome email to newly registered courier
  # Params: email_address of the newly registerd courier
  # Return: email sent to newly registered courier
  # - command :: command line string to be executed by the system
  # - outhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # - errhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def welcome_email(email_address)
    mail(:to => email_address, :subject => 'Welcome to PackageTracker')
  end

  # send emails to registered courier for packages information
  # Params: Current time, packages to be delivered,  email_addresses of the registered couriers
  # Return: email sent to registered couriers
  # - command :: command line string to be executed by the system
  # - outhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # - errhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def packages_notification(current_time,packages,recipients)

    @recipients = recipients
    @packages = packages
    @current_time = current_time

    mail(:cc => @recipients, :subject => 'Packages to be delivered')
  end
end
