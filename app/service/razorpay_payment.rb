class RazorpayPayment
	require 'razorpay'
		
	def initialize
		#Razorpay.setup('rzp_test_ZrT7bSS6LMCvO2', 'IoGZ2x9TzWgzIaEgQrQAKRlY')
	Razorpay.setup('rzp_test_jgok7moG1vXEGD', 'ZrjRVbWdWMy7omrIHEG7Nsky')
	end 

	def create_razorpay_order(total)
		Razorpay::Order.create({amount: total, currency: "INR"})
	end

	def verify_payment_status(razorpay_order_id,razorpay_payment_id,razorpay_signature)
		payment_response = {
			:razorpay_payment_id => razorpay_payment_id,
			:razorpay_order_id => razorpay_order_id,
			:razorpay_signature => razorpay_signature
		}

		Razorpay::Utility.verify_payment_signature(payment_response)

	end
end


