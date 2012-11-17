namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    City.create!(name: "Example City - Warszawa",
                 country: "Poland")
    99.times do |n|
      name  = Faker::Address.city
      country = Faker::Address.country
      City.create!(name: name,
                   country: country)
    end

    cities = City.all(limit: 6)
    50.times do
      name = Faker::Lorem.sentence(1).slice(0..5)
      cities.each { |city| city.clubs.create!(name: name) }
    end
  end
end
