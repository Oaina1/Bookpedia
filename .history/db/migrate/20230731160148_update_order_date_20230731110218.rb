class UpdateOrderDate < ActiveRecord::Migration[7.0]
  def change
    change_column_default :orders, :date, -> { 'CURRENT_DATE' }
  end
end
