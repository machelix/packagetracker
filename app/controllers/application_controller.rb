class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  http_basic_authenticate_with name: "admin", password: "alphabetagamma"
  @city_db_id_a = '81673'
  @city_db_id_b = '13407'

  def self.when_to_run
    1.minutes.from_now
  end

  def dispatch_package_emails_a
    @packages_a , @current_time = dispatch_packages(@city_db_id_a)
    @emails_a = dispatch_emails(:city_db_id => @city_db_id_a)
  end
  handle_asynchronously :dispatch_package_emails_a, :run_at => Proc.new { when_to_run }

  def dispatch_package_emails_b
    @packages_b , @current_time = dispatch_packages(@city_db_id_b)
    @emails_b = dispatch_emails(:city_db_id => @city_db_id_b)
  end
  handle_asynchronously :dispatch_package_emails_b, :run_at => Proc.new { when_to_run }
end
