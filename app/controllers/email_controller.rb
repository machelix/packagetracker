class EmailController < ActionController::Base
  include EmailHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :exception

  # Runs a new action for package i.e. to initiate new email object or a new unsaved record
  # Params:
  # - command :: command line string to be executed by the system
  # - outhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # - errhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def new
    @email = Email.new
  end

  # Runs a create for email
  # Params: city db id for email record
  # - command :: command line string to be executed by the system
  # - outhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # - errhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def create
    @email = Email.new(email_params)

    begin
     if @email.save!
       @city = City.new(city_params.merge(:city_db_id => @email.city_db_id, :email_db_id => @email.id))
       if @city.save!

         # Tell the Emailer to send a welcome email after save
         Emailer.welcome_email(@email.email_value).deliver

         render 'email/register'
       end
     end
    rescue => e
      #p e.message
      #p e.backtrace
      @errors = e.message
      render 'application/error' , :status => 400
    end
  end

  private
  # Private method available to email controller methods : used for strongly checking paramaters to various actions inside email controller
  # Params: permitted city db id for email controller
  # - command :: command line string to be executed by the system
  # - outhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # - errhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def email_params
    params.require(:email).permit(:email_value,:city_db_id)
  end

  # Private method available to package controller methods : used for strongly checking paramaters to various actions to City model
  # Params: permitted city db id & Package db id for city model
  # - command :: command line string to be executed by the system
  # - outhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # - errhandler :: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def city_params
    params.permit(:city_db_id, :email_db_id )
  end
end
