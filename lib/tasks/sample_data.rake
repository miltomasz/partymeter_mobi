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
  end
end
