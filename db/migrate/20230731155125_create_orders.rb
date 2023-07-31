class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.date :date
      t.decimal :total_amount
      t.decimal :gst
      t.decimal :pst
      t.decimal :hst
      t.string :status
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
