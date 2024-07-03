class Order < ApplicationRecord
	has_many :order_items, dependent: :destroy
	belongs_to :user
	belongs_to :address, optional: true
	enum :status, [:cart, :address, :payment, :complete]

	
	private
	def set_total
		self[total] = total  
	end

end
