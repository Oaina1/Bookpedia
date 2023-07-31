class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order

  validates :quantity, :price, presence: true, :numericality => true
  validates :quantity, numericality: { greater_than: 0 }
end
