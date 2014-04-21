require 'test_helper'

class PackageTest < ActiveSupport::TestCase
  test "Package city db id must not be empty" do
    package = Package.new
    assert package.invalid? , msg='Empty city id accepted'
    assert package.errors[:city_db_id].any?
  end

  test "Package City id must be 5 characters" do
    package = Package.new

    package.city_db_id = "1234"
    assert package.invalid? , msg='4 Characters city id accepted'

    package.city_db_id = "12"
    assert package.invalid? , msg='2 Characters city id accepted'

    package.city_db_id = ""
    assert package.invalid? , msg='0 Characters city id accepted'

    package.city_db_id = "1234567890"
    assert package.invalid?  , msg='10 Characters city id accepted'

    package.city_db_id = "XXXXX"
    assert package.invalid?  , msg='5 X Characters city id accepted'

    package.city_db_id = "12345"
    assert_not package.invalid? , msg='5 Characters city id not accepted'
  end
end
