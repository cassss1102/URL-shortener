# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Visit.destroy_all
User.destroy_all
ShortenedUrl.destroy_all

user1 = User.new(email: "user1@gmail.com")
user2 = User.new(email: "user2@gmail.com")

user1.save
user2.save

url1 = ShortenedUrl.shorten_url(user1, "www.google.com")
url2 = ShortenedUrl.shorten_url(user2, "www.amazon.com")

url1.save
url2.save

Visit.record_visit!(user2, url1)
Visit.record_visit!(user1, url1)

Visit.record_visit!(user1, url2)
Visit.record_visit!(user1, url2)
Visit.record_visit!(user1, url2)
Visit.record_visit!(user1, url2)
Visit.record_visit!(user1, url2)
Visit.record_visit!(user1, url2)
Visit.record_visit!(user1, url2)
Visit.record_visit!(user1, url2)
Visit.record_visit!(user2, url2)
