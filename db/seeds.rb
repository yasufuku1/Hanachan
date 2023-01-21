# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Admin.create!(
#   email: "a@a",
#   password: "aaaaaa"
# )
# User.create!([
#     { name: 'test1', email: 'test@test', password: 'testtest' },
#     { name: 'test2', email: 'test1@test', password: 'testtest' },
#     { name: 'test3', email: 'test2@test', password: 'testtest' },
#     ])
Admin.create!(
  email: "ENV['ADMIN_EMAIL']",
  password: "ENV['ADMIN_PASSWORD']"
)