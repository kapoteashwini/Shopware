class Api::V1::Admin::ProductsController < Api::V1::ApiApplicationController

  # before_action :current_user

	def create
    product = Product.new(prod_params)
    authorize product
    if product.save
      render json: product.as_json(include: [:category], methods: [:image_url]), status: 200
    else
      render json: {error: "Product not create"}
    end
  end

  def update
    @product = Product.find_by(id: params[:id])
    authorize @product
    if @product.update(prod_params)
      render json: @product, status: 200
    else 
      render json: {error: "not updated"}
    end
  end

  def admin_list
    authorize Product # we don't have a particular post to authorize
    # Rest of controller action
  end

  def destroy
    @product = Product.find(params[:id])
    authorize @product
    if @product.destroy
      render json: {message: 'Successfully deleted'}
    end
  end

   private
   
	  def prod_params
	    params.permit([:name, :price, :category_id, :desc, :image])
	  end

    # def current_user
    #   jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
    #   auth = jwt_payload['sub'].to_i
    #   @user = User.find(auth)
    #   return @user
    # end
end
