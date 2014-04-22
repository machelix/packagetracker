require 'test_helper'

class EmailerTest < ActionMailer::TestCase
  include PackageHelper
  include EmailHelper
  test "create welcome email for courier" do
    email = Emailer.welcome_email('rails.action.mailer@gmail.com')

    assert_equal 'rails.action.mailer@gmail.com', email['from'].to_s

    assert_equal 'rails.action.mailer@gmail.com', email['to'].to_s
  end

  test "Send welcome email to new courier" do
     email = Emailer.welcome_email('rails.action.mailer@gmail.com').deliver

     assert_equal 'rails.action.mailer@gmail.com', email['from'].to_s

     assert_equal 'rails.action.mailer@gmail.com', email['to'].to_s
  end

  test "Send packages notification to couriers" do
    current_time = Time.now
    packages = find_packages('12345')
    recipients = find_emails('12345')

    mail = Emailer.packages_notification(current_time,packages,recipients).deliver

    assert_equal 'rails.action.mailer@gmail.com', mail['from'].to_s
  end
end
