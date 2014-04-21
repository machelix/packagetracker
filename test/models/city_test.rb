require 'test_helper'

class CityTest < ActiveSupport::TestCase
  test "City city db id must not be empty" do
    city = City.new
    assert city.invalid? , msg='Empty city id accepted'
    assert city.errors[:city_db_id].any?
  end

  test "City City id must be 5 characters" do
    city = City.new

    city.city_db_id = "1234"
    assert city.invalid? , msg='4 Characters city id accepted'

    city.city_db_id = "12"
    assert city.invalid? , msg='2 Characters city id accepted'

    city.city_db_id = ""
    assert city.invalid? , msg='0 Characters city id accepted'

    city.city_db_id = "1234567890"
    assert city.invalid?  , msg='10 Characters city id accepted'

    city.city_db_id = "XXXX1"
    assert city.invalid?  , msg='5 X Characters city id accepted'

    city.city_db_id = "12345"
    assert_not city.invalid? , msg='5 Characters city id not accepted'
  end

  test "City package db id can be empty" do
    city = City.new

    city.city_db_id = "12345"
    city.package_db_id = nil
    assert_not city.invalid? , msg='5 Characters city id not accepted'
  end

  test "City email db id can be empty" do
    city = City.new

    city.city_db_id = "12345"
    city.email_db_id = nil
    assert_not city.invalid? , msg='5 Characters city id not accepted'
  end
end
