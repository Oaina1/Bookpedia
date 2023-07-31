ActiveAdmin.register Book do
  config.filters = false

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :author, :genre_id, :publisher, :price, :on_sale
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :author, :genre_id, :publisher, :price, :on_sale]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
