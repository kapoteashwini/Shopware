class TwilioSms
	require 'rubygems' 
    require 'twilio-ruby' 

    attr_accessor :mobile_number, :message, :account_sid, :auth_token, :service

    def initialize(mobile_number, message)
    	
	end 


	def send_message 	
    @client = Twilio::REST::Client.new(account_sid, auth_token) 
 
    @message = @client.messages.create( 
                             body: "hii.." ,
                             messaging_service_sid: @service,      
                             to: @mobile_number 
                           ) 
	 end
