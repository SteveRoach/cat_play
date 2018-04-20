require 'factory_girl' 
 
FactoryGirl.define do 
  factory :message do 
    name    { Faker::Name.name } 
    email   { Faker::Internet.email(name) } 
    subject { Faker::Lorem.sentence(3) } 
    message { Faker::Lorem.paragraph(2) } 
  end 
end
