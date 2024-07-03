ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :price, :image, :desc, :category_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :price, :quantity, :image, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :category
    column :desc

    column :image do |product|
      if product.image.present?
        image_tag product.image, width: '75', height: '75'
      end
    end

    column :created_at
    actions
  end

  form do |f|
    f.inputs          # builds an input field for every attribute
    f.input :image, as: :file
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

  
end
