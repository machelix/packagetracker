module PackageHelper

  def dispatch_packages(city_id)
     @current_time = Time.now
     if city_id == '*'
      packages = City.all
     else
      packages = City.where(:city_db_id => city_id)
     end
     return packages, @current_time
  end

end
