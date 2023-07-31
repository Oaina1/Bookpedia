class Book < ApplicationRecord
  belongs_to :genre
  has_one_attached :image

  validates :name, presence: true
  validates :author, length: { maximum: 100 }
  validates :publisher, length: { maximum: 100 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :on_sale, inclusion: { in: [true, false] }
end
