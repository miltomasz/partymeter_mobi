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
      address = Faker::Lorem.sentence(2).slice(0..10) + " #{rand(100)}"
      cities.each { |city| city.clubs.create!(name: name, address: address) }
    end

    50.times do
      name = Faker::Lorem.sentence(3).slice(0..10)
      description = Faker::Lorem.words
      time = 1.times.map{ 0 + Random.rand(30) }.join.to_i 
      event_date = rand(time.days).ago

      cities.each do |city| 
        clubs = city.clubs.first(6)
        clubs.each { |club| club.events.create!(name: name, description: description, event_date: event_date) }
      end
    end

    5.times do
      author = Faker::Name.name.slice(0..20)
      content = Faker::Lorem.sentence(1).slice(0..10)
      cities.each do |city|
        clubs = city.clubs.first(6)
        clubs.each do |club|
          events = club.events.first(6)
          events.each { |event| event.comments.create!(author: author, content: content) }
        end
      end
    end
  end
end
