class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.references :genre, null: false, foreign_key: true
      t.string :publisher
      t.decimal :price

      t.timestamps
    end
  end
end
