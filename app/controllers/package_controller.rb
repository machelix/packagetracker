class PackageController < ActionController::Base
  include PackageHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def find
    @packages , @current_time = dispatch_packages(params[:city_db_id])
  end

  def new
    @package = Package.new
  end

  def create
    @package = Package.new(package_params)

    if @package.save!
      @city = City.new(city_params.merge(:city_db_id => @package.city_db_id, :package_db_id => @package.id))
      if @city.save!
        render 'package/register'
      else
        render root_path
      end
    else
      render root_path
    end
  end

  private
  def package_params
    params.require(:package).permit(:city_db_id)
  end

  def city_params
    params.permit(:city_db_id, :package_db_id )
  end
end
