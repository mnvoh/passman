FactoryBot.define do
  factory :secure_note do
    title { 'Example' }
    note { ':aes256b64:/4e0Dj6aoyZhs2PFSRJfug==' }
    iv { '7r55o4Fc03tBanpv0bOEKQ==' }
    salt { 'Teq0gez5PiahEZcs6w9yXGFjHEltx8Bz66G+M4nKwQ4=' }
    created_at { 10.days.ago }
    updated_at { 10.days.ago }
    user
  end
end