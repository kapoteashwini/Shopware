class OrderItem < ApplicationRecord
	belongs_to :order
	belongs_to :product

	before_save :set_price_and_total
	after_save :calc_totals
	after_destroy :calc_totals



	def set_price_and_total
		self.price = product.price
		set_total
		#set_order_total
	end

	def set_total
		self.total = price*quantity
	end 

	def calc_totals
  	current_order_total = 0
		order.order_items.each do |order_item|
    	current_order_total += order_item.total.to_i
		end
  	order.update(total: current_order_total)
	end

  # def after_calc_totals
    
  #   current_order_total = self.order.total
  #     current_order_total = current_order_total - total
  #   order.update(total: current_order_total)
  # end

end

    