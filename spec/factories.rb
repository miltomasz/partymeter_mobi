FactoryGirl.define do
  factory :city do
    sequence(:id) { |n| n }
  	sequence(:name)    { |n| "City #{n}" }
    sequence(:country) { |n| "Country #{n}" }   
  end

  factory :club do
    name "Draze"
    description "Hipster cafeteria"
    address "Pulawska 3"
    city
  end
end