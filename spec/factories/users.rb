FactoryGirl.define do
  pw = Faker::Lorem.sentence
  
  factory :user do
    # name Faker::Name.name
    
    sequence(:email){|n| "user#{n}@factory.com" }
    password pw
    password_confirmation pw
    confirmed_at Date.today
    role :standard
  end
end
