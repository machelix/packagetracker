module PackageHelper

  def find_packages(city_id)
     if city_id == '*'
      packages = Package.all
     else
      packages = Package.where(:city_db_id => city_id)
     end
     return packages
  end

end
