class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :full_name
      t.integer :phone_number
      t.integer :pin_code
      t.string :district
      t.string :state
      t.string :city
      t.integer :house_no
      t.string :colony_name

      t.timestamps
    end
  end
end
