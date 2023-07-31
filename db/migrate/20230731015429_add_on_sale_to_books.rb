class AddOnSaleToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :on_sale, :boolean
  end
end
