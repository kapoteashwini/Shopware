class Api::V1::ApiApplicationController < ActionController::Base
	skip_before_action :verify_authenticity_token
	before_action :current_user
	
	include Pundit::Authorization


	private

	def current_user
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
      auth = jwt_payload['sub'].to_i
      @user = User.find(auth)
      return @user
   	end

end
