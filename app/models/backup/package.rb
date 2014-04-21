class Package < ActiveRecord::Base
  validates :package_db_id, presence: true #, length: { maximum: 5, minimum: 5}
end
