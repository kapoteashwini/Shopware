class Api::V1::OrderItemsController < Api::V1::ApiApplicationController
	before_action :find_cart_order
	
	def add_to_cart
		@order_item = @order.order_items.find_or_initialize_by(product_id: params[:product_id])
		@order_item.quantity = @order_item.quantity.to_i + 1
		if @order_item.save
			flash[:notice] = "Item added_to_cart."
			#redirect_to root_path
			return render json: @order_item ,status: :ok
		else
  			flash[:notice] = "Unable to add item into cart. Please try again"
  			return render json: @order_item.errors, status: :unprocessable_entity
    		#redirect_to root_path
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
    return render json:@order_item, status: :ok
    #redirect_to cart_path
  end

end