class AddAddressIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :address_id, :integer
  end
end
