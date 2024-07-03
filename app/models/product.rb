class Product < ApplicationRecord
	include Rails.application.routes.url_helpers

	has_one_attached :image
	belongs_to :category
	has_many :order_items

	def image_url
		if self.image.attached?
	  		url_for(image)
		end
	end


  # def image_url
  # 	if self.image.attached?
  #   	rails_blob_path(self.image, disposition: "attachment")
  #   end
  # end
end
