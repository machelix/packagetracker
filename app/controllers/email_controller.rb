class EmailController < ActionController::Base
  include EmailHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def find
    @emails = dispatch_emails(params[:city_db_id])
  end

  def new
    @email = Email.new
  end

  def create
    @email = Email.new(email_params)

    if @email.save!
      @city = City.new(city_params.merge(:city_db_id => @email.city_db_id, :email_db_id => @email.id))
      if @city.save!
        render 'email/register'
      else
        render root_path
      end
    else
      render root_path
    end
  end

  private
  def email_params
    params.require(:email).permit(:email_value,:city_db_id)
  end

  def city_params
    params.permit(:city_db_id, :email_db_id )
  end
end
