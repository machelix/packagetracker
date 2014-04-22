module EmailHelper

  # find emails with specific city db id from email records
  # Params: city_id - city db id to be searched from records
  # Return: ActiveRelation[] of matching emails records
  # - command :: command line string to be executed by the system
  # - outhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # - errhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def find_emails(city_id)
     if city_id == '*'
      emails = Email.all
     else
      emails = Email.where(:city_db_id => city_id)
     end
     return emails
  end

end
