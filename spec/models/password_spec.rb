require 'rails_helper'

RSpec.describe Password, type: :model do
  let(:password) { create(:password) }
  it 'user should exist' do
    expect(password.user).not_to be(nil)
  end

  it 'unencrypted data shouldn\'t be save' do
    password.password = '123123'
    expect { password.save }.to raise_error(/encrypt_password/)
  end

  it 'encryption should work as expected' do
    password.iv = 'oW3QpoZOTg+6aD8BgbBf7Q=='
    password.salt = '6Py5zWaPCBXUMHK0CxKrdfJdH/SHB4JcPeQ3DOt15EQ='
    password.password = TEST_PASSWORD
    password.description = TEST_PASSWORD
    password.encrypt_data(TEST_PASSWORD)
    expect("#{password.password}#{password.description}").to eq(':aes256b64:P1Y80mE53YJ6mQ91EV8mbA==:aes256b64:P1Y80mE53YJ6mQ91EV8mbA==')
  end
end
