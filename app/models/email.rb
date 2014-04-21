class Email < ActiveRecord::Base
  validates :city_db_id, :presence => true , :length => { :maximum => 5, :minimum => 5 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email_value, :presence => true, :format => { :with => VALID_EMAIL_REGEX }  , :length => { :maximum => 50, :minimum => 2}

end
