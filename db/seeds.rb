# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD']
)
users = User.create!([
  { name: 'flower1', email: 'test1@test', password: 'testtest', introduction: 'はじめまして', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/sample-user1.jpg"), filename:"sample-user1.jpg") },
  { name: 'flower2', email: 'test2@test', password: 'testtest', introduction: 'よろしくお願いします', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/sample-user2.jpg"), filename:"sample-user2.jpg") },
])
Post.create!([
  { image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/sample-post1.jpg"), filename:"sample-post1.jpg"), title: '黄色いお花', body: '部屋が寂しかったので、明るい色のお花で部屋の雰囲気を変えてみました。', user_id: users[0].id},
  { image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/sample-post2.jpg"), filename:"sample-post2.jpg"), title: 'キッチンに飾ってみました', body: '料理をする時間が増えたので、キッチンにチューリップを飾ってみました。', user_id: users[1].id},
 ])
