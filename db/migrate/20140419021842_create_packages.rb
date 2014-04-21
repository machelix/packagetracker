class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.integer :city_db_id

      t.timestamps
    end
  end
end
