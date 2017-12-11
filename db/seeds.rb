# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

POST_NUMBER = 200_000
USER_NUMBER = 100
IP_NUMBER = 50

logins = (0...USER_NUMBER).map { FFaker::Internet.user_name }.freeze
ips = (0...IP_NUMBER).map { FFaker::Internet.ip_v4_address }.freeze

POST_NUMBER.times do |post_number|
  post = Post.create_with_user! FactoryBot.attributes_for(:post, ip_address: ips.sample),
                                {login: logins.sample}

  if rand < 0.1 # 10% постов получают оценки
    rand(1..10).times do
      post.rate! rand(1..5)
    end
  end

end