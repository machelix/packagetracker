class PackageController < ActionController::Base
  include PackageHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :exception

  # Runs a new action for package i.e. to initiate new package object or a new unsaved record
  # Params:
  # - command :: command line string to be executed by the system
  # - outhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # - errhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def new
    @package = Package.new
  end

  # Runs a create for package
  # Params: city db id for package record
  # - command :: command line string to be executed by the system
  # - outhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # - errhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
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
  # Private method available to package controller methods : used for strongly checking paramaters to various actions inside package controller
  # Params: permitted city db id for package controller
  # - command :: command line string to be executed by the system
  # - outhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # - errhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def package_params
    params.require(:package).permit(:city_db_id)
  end

  # Private method available to package controller methods : used for strongly checking paramaters to various actions to City model
  # Params: permitted city db id & Package db id for city model
  # - command :: command line string to be executed by the system
  # - outhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # - errhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def city_params
    params.permit(:city_db_id, :package_db_id )
  end
end
