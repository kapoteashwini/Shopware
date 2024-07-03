class CartsController < ApplicationController
	
  before_action :find_order
  before_action :find_all_address, only: [:address, :address_create]

  def cart
  	
	end

	def index
		respond_to do |format|
			format.html{
				orders = Order.all
			}

			format.json{
				render json: Order.all
			}
		end
	end

	def address
    @new_address = Address.new
	end


	def address_create
		@address = current_user.addresses.new(address_params)
    if @address.save
			redirect_to carts_address_path
		else
			render :address, status: :unprocessable_entity
		end
	end

	def remove_address
    @address = Address.find(params[:address_id])
    if @address.destroy
      redirect_to carts_address_path, notice: "address removed"
    end
  end

  def assign_address
    @order.update(assign_address_params)
    redirect_to  carts_payment_path
  end


	def payment
		razorpay_payment = RazorpayPayment.new
		razorpay_order = razorpay_payment.create_razorpay_order(@order.total.to_i*100)
		if razorpay_order.id
			@order.update(razorpay_order_id: razorpay_order.id)
		end
	end

	def payment_success
		razorpay_payment = RazorpayPayment.new
		response = razorpay_payment.verify_payment_status(params[:razorpay_order_id], params[:razorpay_payment_id], params[:razorpay_signature])
		if response
			@order.update(status: :complete)
			OrderMailer.order_completed(current_user).deliver_now
			phone = @order.address.phone_number.to_s
			code = "+91"
			phone_code = code + phone
			t= TwilioSms.new(phone_code,"hii")
			t.send_message
			redirect_to carts_complete_path
		end
	end

	def complete

	end

	def destroy
	end

	

	
	private
	def address_params
		params.require(:address).permit(:full_name, :phone_number, :pin_code, :district, :state, :city, :house_no, :colony_name)
	end

  def assign_address_params
    params.require(:order).permit(:address_id)
  end

  def find_order
    @order = current_user.orders.where.not(status: 'complete').first
  end

  def find_all_address
    @addresses = current_user.addresses
  end
end