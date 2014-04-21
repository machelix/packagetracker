class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :package_db_id
      t.integer :email_db_id
      t.integer :city_db_id

      t.timestamps
    end
  end
end
