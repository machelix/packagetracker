require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  test "should get index" do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:alphabetagamma")

    get :index

    assert_response :success

    assert_template :index
  end

  test "should be able to post index" do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:alphabetagamma")

    post :index

    assert_response :success

    assert_template :index
  end

  test "should get index with params" do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:alphabetagamma")

    get :index , :email => { :city_db_id => "12345", :email_value => "test@testing.com" }

    assert_response :success

    assert_template :index
  end

  test "should be able to post index with params" do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:alphabetagamma")

    #post :new , :email => { :city_db_id => "12345", :email_value => "test@testing.com" }

    #assert_response :success

    #assert_template :index

    #ActionController::UrlGenerationError: No route matches
  end

  test "should get dispatch" do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:alphabetagamma")

    get :dispatch

    assert_response :success

    assert_template :dispatch
  end

  test "should be able to post dispatch" do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:alphabetagamma")

    post :dispatch

    assert_response :success

    assert_template :dispatch
  end

  test "should get dispatch with params" do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:alphabetagamma")

    get :dispatch , :email => { :city_db_id => "12345", :email_value => "test@testing.com" }

    assert_response :success

    assert_template :dispatch
  end

  test "should get notify_couriers with params" do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:alphabetagamma")

    get :notify_couriers , :application => {:city_db_id => "12345"}

    assert_response :success

    assert_template :notify_couriers
  end

  test "should be able to post notify_couriers with params" do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:alphabetagamma")

    assert_recognizes({:controller => 'application', :action => 'notify_couriers'}, { :path => 'dispatch', :method => :post})

    post :notify_couriers , :application => {:city_db_id => "12345"}

    assert_response :success

    assert_template :notify_couriers

    # Assert that the controller really put the record in the database.
    assert_not_nil Email.find_by(:city_db_id => "12345")

    # Assert that the controller really put the record in the database.
    assert_not_nil Package.find_by(:city_db_id => "12345")
  end

  test "should get scheduled_notification with params" do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:alphabetagamma")

    get :scheduled_notification , { :application => {:city_db_id => "12345"} , :time => ["14:00", "15:00"]}

    assert_response :success

    assert_template :scheduled_notification
  end

  test "should be able to post scheduled_notification with params" do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:alphabetagamma")

    assert_recognizes({:controller => 'application', :action => 'scheduled_notification'}, { :path => 'schedule', :method => :post})

    post :scheduled_notification , { :application => {:city_db_id => "12345"} , :time => ["14:00", "15:00"]}

    assert_response :success

    assert_template :scheduled_notification
  end

  test "not happy path get test" do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:alphabetagamma")

    begin
      get :find
    rescue Exception => e
      assert(e.message.match("No route matches"))
      assert_equal(e.class,ActionController::UrlGenerationError)
    end
  end

  test "not happy path post test" do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:alphabetagamma")

    begin
      post :find
    rescue Exception => e
      assert(e.message.match("No route matches"))
      assert_equal(e.class,ActionController::UrlGenerationError)
    end
  end
end