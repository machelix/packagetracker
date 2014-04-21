require 'test_helper'

class EmailTest < ActiveSupport::TestCase
  test "Email city db id must not be empty" do
    email = Email.new
    assert email.invalid? , msg='Empty city id accepted'
    assert email.errors[:city_db_id].any?
  end

  test "Email City id must be 5 characters" do
    email = Email.new

    email.city_db_id = "1234"
    assert email.invalid? , msg='4 Characters city id accepted'

    email.city_db_id = "12"
    assert email.invalid? , msg='2 Characters city id accepted'

    email.city_db_id = ""
    assert email.invalid? , msg='0 Characters city id accepted'

    email.city_db_id = "1234567890"
    assert email.invalid?  , msg='10 Characters city id accepted'

    email.city_db_id = "XXXX1"
    assert email.invalid?  , msg='5 X Characters city id accepted'

    email.city_db_id = "12345"
    email.email_value = "test@test.com"
    assert_not email.invalid?  , msg='5 Characters city id not accepted'
  end

  test "Email email must not be empty" do
    email = Email.new
    email.city_db_id = "12345"
    assert email.invalid? , msg='Empty email accepted'
    assert email.errors[:email_value].any?
  end

  test "Email email must be have proper email format" do
    email = Email.new
    email.city_db_id = "12345"

    email.email_value = "1234"
    assert email.invalid? , msg='1234 not proper format'

    email.email_value = "12@"
    assert email.invalid? , msg='12@ not proper format'

    email.email_value = "raj@test"
    assert email.invalid? , msg='raj@test not proper format'

    email.email_value = "raj@test."
    assert email.invalid? , msg='raj@test. not proper format'

    email.email_value = "test@test.com"
    assert_not email.invalid?  , msg='email id not accepted'
  end
end
