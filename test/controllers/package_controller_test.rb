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


  #test "should post create but wrong city id" do
    # Simulate a POST response with the given HTTP parameters.
  #  assert_raises('Class: <ActiveRecord::RecordInvalid>
  #  Message: <"Validation failed: City db is too short (minimum is 5 characters)">') {
  ##       post :create , :package => { :city_db_id => "1111X" }
  #  }
  #end

  #test "should not get index" do
  #  get :index
  #  post :find
  #  assert_response :error
  #end
end