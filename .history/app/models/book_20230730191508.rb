class Book < ApplicationRecord
  belongs_to :genre
  has_one_attached :image

  validates :name, presence: true
  validates :author, presence: true
  validates :genre_id, presence: true
  validates :publisher, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
