# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'

# Your other seed code goes here

# Seed data from CSV file
csv_file_path = Rails.root.join('db', 'books_data.csv')

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
  unsplash_image_name = URI.encode_www_form_component(product_data['name'])
  unsplash_image_url = "https://source.unsplash.com/800x600/?#{unsplash_image_name}"
  image_io = URI.open(unsplash_image_url)
  book.image.attach(
    io: image_io,
    filename: "book_#{book.id}.jpg",
    content_type: 'image/jpeg'
  )
end
