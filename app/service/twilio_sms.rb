class TwilioSms
	require 'rubygems' 
    require 'twilio-ruby' 

    attr_accessor :mobile_number, :message, :account_sid, :auth_token, :service

    def initialize(mobile_number, message)
    	@account_sid = 'AC348e9e4776a6a3a2fbaf6ba8f90b68fd' 
   		@auth_token = '929c7ce766182d618c44873fd56c290a'
   		@service = 'MG1130bb962ec8ab447d9754e832569db6'	
   		@message = message
   		@mobile_number = mobile_number
	end 


	def send_message 	
    @client = Twilio::REST::Client.new(account_sid, auth_token) 
 
    @message = @client.messages.create( 
                             body: "hii.." ,
                             messaging_service_sid: @service,      
                             to: @mobile_number 
                           ) 
	 end
end