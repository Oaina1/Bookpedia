class Province < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :pst, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :gst, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :hst, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
