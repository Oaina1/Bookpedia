class Order < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :order_items
  has_many :books, through: :order_items

  validates :order_date, presence: true
  validates :gst, :hst, :pst, :total_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: %w[new paid shipped] }


end
