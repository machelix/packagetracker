require 'test_helper'

class PackageControllerTest < ActionController::TestCase
  test "should get new" do
    get :new

    assert_response :success

    assert_template "package/new"
  end

  test "should be able to post new" do
    post :new

    assert_response :success

    assert_template "package/new"
  end

  test "should get new with params" do
    get :new , :package => { :city_db_id => "12345" }

    assert_response :success

    assert_template "package/new"
  end

  test "should be able to post new with params" do
    post :new , :package => { :city_db_id => "12346" }

    assert_response :success

    assert_template "package/new"

    # Assert that the controller really put the record in the database.
    assert_nil Package.find_by(:city_db_id => "12346"), msg='package record created'

    # makes sure that a @package instance variable was set
    assert_not_nil assigns(:package), msg='@package variable set'
  end

  test "should post create" do
    # Simulate a POST response with the given HTTP parameters.
    post :create , :package => { :city_db_id => "12345" }

    assert_response :success

    assert_template "package/register"

    # Assert that the controller really put the record in the database.
    assert_not_nil Package.find_by(:city_db_id => "12345")

    # makes sure that a @package instance variable was set
    assert_not_nil assigns(:package)

    # Assert that the controller really put the record into city database too.
    assert_not_nil City.find_by(:city_db_id => "12345")

    # makes sure that a @city instance variable was set
    assert_not_nil assigns(:city)
  end


  test "should post create but without city id param" do
    # Simulate a POST response with the given HTTP parameters.
    begin
      post :create
    rescue => e
      assert(e.message.match("param is missing or the value is empty: package"))
    end
  end

  test "should post create but empty city id" do
    # Simulate a POST response with the given HTTP parameters.
    post :create , :package => { :city_db_id => "" }

    assert_response 400
    assert(@response.status_message.match("Bad Request"))
    assert(@response.body.match("Validation failed: City db can&#39;t be blank") , msg="failed to check blank citd id validation")
  end

  test "should post create but wrong city id" do
    # Simulate a POST response with the given HTTP parameters.
    post :create , :package => { :city_db_id => "1xxxX" }

    assert_response 400
    assert(@response.status_message.match("Bad Request"))
    assert(@response.body.match("Validation failed: City db is too short") , msg="failed to check wrong city id validation")
  end
end