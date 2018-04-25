# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
  Coach.create({
                   mail_address: Faker::Internet.email,
                   password: Faker::Internet.password(3, 6),
                   name: Faker::Name.first_name,
                   last_name: Faker::Name.last_name
               })
end

# Seed 10 active clients
10.times do
  Client.create({
                    coach: Coach.find(Random.rand(1..5)),
                    mail_address: Faker::Internet.email,
                    password: Faker::Internet.password(3, 6),
                    name: Faker::Name.first_name,
                    last_name: Faker::Name.last_name,
                    is_pending: false,
                    is_active: true
                })
end

# Seed 10 blocked clients
10.times do
  Client.create({
                    coach: Coach.find(Random.rand(1..5)),
                    mail_address: Faker::Internet.email,
                    password: Faker::Internet.password(3, 6),
                    name: Faker::Name.first_name,
                    last_name: Faker::Name.last_name,
                    is_pending: false,
                    is_active: false
                })
end

# Seed 10 pending clients
10.times do
  Client.create({
                    coach: Coach.find(Random.rand(1..5)),
                    mail_address: Faker::Internet.email,
                    password: Faker::Internet.password(3, 6),
                    name: Faker::Name.first_name,
                    last_name: Faker::Name.last_name,
                    is_pending: true,
                    is_active: nil
                })
end

(1..30).each {|i|
  Training.create({
                      client: Client.find(i),
                      name: Faker::StarWars.character,
                      weekday: Random.rand(6)
                  })
}

5.times do
  Exercise.create({
                      name: Faker::Food.dish,
                      category: :triceps
                  })
end
