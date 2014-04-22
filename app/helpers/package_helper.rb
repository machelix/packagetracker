module PackageHelper

  # find packages with specific city db id from package records
  # Params: city_id - city db id to be searched from records
  # Return: ActiveRelation[] of matching package records
  # - command :: command line string to be executed by the system
  # - outhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # - errhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def find_packages(city_id)
     if city_id == '*'
      packages = Package.all
     else
      packages = Package.where(:city_db_id => city_id)
     end
     return packages
  end

end
