FactoryBot.define do
  factory :password do
    title { 'Example' }
    url { 'https://example.com' }
    password { ':aes256b64:rJFH7EqrDBzMGYsFFiPl3Q==' }
    description { ':aes256b64:0vZvCl/G/bWVu6tLjQ/ZB7zbPTP+OVd60v9JaSefKgo=' }
    iv { '7r55o4Fc03tBanpv0bOEKQ==' }
    salt { 'Teq0gez5PiahEZcs6w9yXGFjHEltx8Bz66G+M4nKwQ4=' }
    password_strength { 0 }
    created_at { 10.days.ago }
    updated_at { 10.days.ago }
    password_updated_at { 10.days.ago }
  end
end