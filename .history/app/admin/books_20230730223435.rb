ActiveAdmin.register Book do
  config.filters = false

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :author, :genre_id, :publisher, :price, :on_sale, :image

   # edit and new form page
   form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attributes
    f.inputs do
      if f.object.image.attached?
        f.input :image, as: :file, hint: image_tag(f.object.image.variant(resize_to_fill: [100, 100]))
      else
        f.input :image, as: :file
      end
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end


   # index page
  index do
    selectable_column
    id_column
    column :image do |book|
      if book.image.attached?
        image_tag book.image.variant(resize_to_limit: [50, 50])
      else
        "N/A"
      end
    end
    column :name
    column :author
    column :genre
    column :publisher
    column :price
    column :on_sale
    column :created_at
    column :updated_at
    actions
  end

  # show page
  show do
    attributes_table do
      row :id
      row :name
      row :author
      row :genre
      row :publisher
      row :price
      row :on_sale
      row :image do |book|
        if book.image.attached?
          image_tag book.image.variant(resize_to_limit: [200, 200])
        else
          "No image attached"
        end
      end
    active_admin_comments
  end


end
