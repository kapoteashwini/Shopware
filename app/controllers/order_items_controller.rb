class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_cart_order

  def add_to_cart
  	@order_item = @order.order_items.find_or_initialize_by(product_id: params[:product_id])
  	@order_item.quantity = @order_item.quantity.to_i + 1
  	if @order_item.save
      
  		flash[:notice] = "Item added add_to_cart."
  		redirect_to root_path
  		#redirect_to cart_path(@cart)
  	else
  		flash[:notice] = "Unable to add item into cart. Please try again"
    	redirect_to root_path
    end
  end


  def find_cart_order
    @order = current_user.orders.where.not(status: 'complete').first
    
    if @order.blank?
      # @order = Order.create(user_id: current_user.id)
      @order = current_user.orders.create(status: 'cart')
    end
    @order
  end
  
  def destroy
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    redirect_to cart_path
  end

  
end
