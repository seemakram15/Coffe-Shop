# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times.map do |i|
  User.create!(
    first_name: 'User',
    last_name: (i + 1).to_s,
    email: "user#{i + 1}@gmail.com",
    phone_number: "238254129#{i}"
  )
end

categories_data = {
  'Coffee' => %w[Espresso Americano Latte Cappuccino],
  'Teas' => ['Black Tea', 'Green Tea', 'Herbal Tea'],
  'Specialty Drinks' => ['Smoothies', 'Milkshakes', 'Hot Chocolate'],
  'Baked Goods' => %w[Pastries Cookies Brownies],
  'Breakfast Items' => ['Bagels', 'Breakfast Sandwiches', 'Granola Parfait'],
  'Snacks' => ['Chips', 'Nuts', 'Fruit Cups'],
  'Sweets & Desserts' => %w[Cakes Tarts]
}

categories_data.each do |category_name, items|
  category = Category.create!(name: category_name)
  items.each do |item_name|
    price = rand(2.5..10).round(2)
    tax = rand(2.0..5.0).round(2)
    discount = rand(20..40)

    Item.create!(
      name: item_name,
      category: category,
      price: price,
      tax: tax,
      discount: discount
    )
  end
end
