class UpdatePhoneNumberRangeInAddresses < ActiveRecord::Migration[7.0]
  def change
    change_column :addresses, :phone_number, :integer, limit: 8
  end
end
