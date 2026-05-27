# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Category.create(name: "Skincare")
Category.create(name: "Face")
Category.create(name: "Eye")
Category.create(name: "Lip")
Category.create(name: "Body")
Category.create(name: "Hair")
Category.create(name: "SPF")

#sample user and product for demo 

# Find or create a demo user
user = User.find_or_create_by(email: "demo@shelfcare.com") do |u|
  u.password = "123456"
end

# Create sample products
user.products.create(name: "NARS Radiant Creamy Concealer", brand: "NARS", open_date: 2.years.ago, pao_months: 12, category: Category.find_by(name: "Face"))
user.products.create(name: "Rare Beauty Blush", brand: "Rare Beauty", open_date: 3.months.ago, pao_months: 6, category: Category.find_by(name: "Face"))
user.products.create(name: "MAC Studio Fix Foundation", brand: "MAC", open_date: 1.month.ago, pao_months: 12, category: Category.find_by(name: "Face"))
user.products.create(name: "Charlotte Tilbury Mascara", brand: "Charlotte Tilbury", open_date: 5.months.ago, pao_months: 6, category: Category.find_by(name: "Eye"))
user.products.create(name: "Fenty Beauty Gloss", brand: "Fenty Beauty", open_date: 1.year.ago, pao_months: 12, category: Category.find_by(name: "Lip"))
user.products.create(name: "Tatcha Moisturizer", brand: "Tatcha", open_date: 6.months.ago, pao_months: 12, category: Category.find_by(name: "Skincare"))
