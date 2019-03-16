require 'rails_helper'

RSpec.describe SecureNote, type: :model do
  let(:secure_note) { create(:secure_note) }

  it 'user should exist' do
    expect(secure_note.user).not_to be(nil)
  end

  it 'unencrypted data shouldn\'t be save' do
    secure_note.note = '123123'
    expect { secure_note.save }.to raise_error(/encrypt/)
  end

  it 'encryption should work as expected' do
    secure_note.iv = 'oW3QpoZOTg+6aD8BgbBf7Q=='
    secure_note.salt = '6Py5zWaPCBXUMHK0CxKrdfJdH/SHB4JcPeQ3DOt15EQ='
    secure_note.note = TEST_PASSWORD
    secure_note.encrypt_note(TEST_PASSWORD)
    expect(secure_note.note).to eq(':aes256b64:P1Y80mE53YJ6mQ91EV8mbA==')
  end
end
