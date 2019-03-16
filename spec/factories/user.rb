require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123123' }
    created_at { 10.days.from_now }
    updated_at { DateTime.now }
  end
end