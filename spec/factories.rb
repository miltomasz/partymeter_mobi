FactoryGirl.define do
  factory :city do
  	sequence(:name)    { |n| "City #{n}" }
    sequence(:country) { |n| "Country #{n}" }   
  end
end