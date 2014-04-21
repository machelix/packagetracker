module EmailHelper

  def dispatch_emails(city_id)
     if city_id == '*'
      emails = Email.all
     else
      emails = Email.where(:city_db_id => city_id)
     end
     return emails
  end

end
