class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :category_id
      t.text :desc
      t.timestamps
    end
  end
end
