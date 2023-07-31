# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'
require 'faker'
Book.destroy_all
Genre.destroy_all
Province.destroy_all

# Your other seed code goes here

# Seed data from CSV file
csv_file_path = Rails.root.join('db', 'books.csv')

CSV.foreach(csv_file_path, headers: true) do |row|
  book_name = row['Title']
  author = row['Author']
  genre_name = row['Genre']
  height = row['Height'].to_i
  publisher = row['Publisher']

  genre = Genre.find_or_create_by(name: genre_name)
  price = Faker::Commerce.price

  book = Book.create(
    name: book_name,
    author: author,
    genre_id: genre.id,
    publisher: publisher,
    price: price
  )

  # Fetch image from Unsplash based on the book name
  unsplash_image_name = URI.encode_www_form_component(book_name)
  unsplash_image_url = "https://source.unsplash.com/800x600/?#{unsplash_image_name}"
  image_io = URI.open(unsplash_image_url)
  book.image.attach(
    io: image_io,
    filename: "book_#{book.id}.jpg",
    content_type: 'image/jpeg'
  )
end

provinces = [
  { name: 'Alberta', gst: 0.05, pst: 0, hst: 0 },
  { name: 'British Columbia', gst: 0.05, pst: 0.05, hst: 0 },
  { name: 'Manitoba', gst: 0.05, pst: 0.07, hst: 0 },
  { name: 'New Brunswick', gst: 0, pst: 0, hst: 0.15 },
  { name: 'Newfoundland and Labrador', gst: 0, pst: 0, hst: 0.15 },
  { name: 'Northwest Territories', gst: 0.05, pst: 0, hst: 0 },
  { name: 'Nova Scotia', gst: 0, pst: 0, hst: 0.15 },
  { name: 'Nunavut', gst: 0.05, pst: 0, hst: 0 },
  { name: 'Ontario', gst: 0, pst: 0, hst: 0.13 },
  { name: 'Prince Edward Island', gst: 0, pst: 0, hst: 0.15 },
  { name: 'Quebec', gst: 0.05, pst: 0.09975, hst: 0 },
  { name: 'Saskatchewan', gst: 0.05, pst: 0.06, hst: 0 },
  { name: 'Yukon', gst: 0.05, pst: 0, hst: 0 }
]
provinces.each do |province|
  Province.create(province)
end

# Book.all.each do |book|
#   book.update(on_sale: [true, false].sample)
# end
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?