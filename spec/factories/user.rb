FactoryBot.define do
  factory :user do
    name { 'Users Name' }
    email { 'users_name@example.com' }
    password { '123123' }
    created_at { 10.days.from_now }
    updated_at { DateTime.now }
  end
end