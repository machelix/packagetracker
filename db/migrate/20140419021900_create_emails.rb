class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.integer :city_db_id
      t.text :email_value

      t.timestamps
    end
  end
end
