class HomeController < ApplicationController
  
  def index
    respond_to do |format|
      format.html {
        #@products = Product.where("LOWER(name) LIKE ? OR price LIKE ?", params[:search.downcase] + "%", params[:search] + "%") if params[:search].present?
        #@products = Product.all if !params[:search].present?
        @products = if params[:search].present?
                      Product.where("LOWER(name) LIKE ? OR price LIKE ?", params[:search.downcase] + "%", params[:search] + "%") 
                    elsif params[:category_id].present?
                      Product.where(category_id: params[:category_id]) if params[:category_id].present?
                    else
                      Product.all
                    end
        if current_user.present?
          @email = current_user.email
        end
      }
      format.json {
         render json: Product.all
      }
    end
  end

    #@order_item = current_order.order_items

  def about
  end

  def users
  end

  def destroy
  end
  
end
