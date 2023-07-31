ActiveAdmin.register Order do
  config.filters = false

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :date, :total_amount, :gst, :pst, :hst, :status, :customer_id


   form do |f|
    f.semantic_errors
    f.inputs do
      f.input :date
      f.input :gst
      f.input :hst
      f.input :pst
      f.input :total_amount
      f.input :status, as: :select, collection: ['new', 'paid', 'shipped']
      f.input :customer_id
    end
    f.actions
  end

end
