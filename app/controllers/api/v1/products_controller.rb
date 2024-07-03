class Api::V1::ProductsController < Api::V1::ApiApplicationController
  # skip_before_action :verify_authenticity_token

  def index
    @products = Product.all
    render json: @products.as_json(methods: [:image_url]), status: 200
  end

  def show
    @product = Product.find_by(id: params[:id])
    if @product.present?
      render json: @product.as_json(methods: [:image_url]), status: 200
    else
      render json: {error: "not found product"}
    end
  end
end
