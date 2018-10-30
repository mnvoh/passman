require 'openssl'
require 'base64'

class Password < ApplicationRecord
  include Security

  before_save do |password|
    unless /^#{FORMAT_STRING}/.match?(password.password)
      raise 'Attempting to save plain text password! Call `encrypt_password`' +
        ' with a master password first.'
    end
  end

  after_initialize do |user|
    if user.salt.nil? || user.iv.nil?
      user.salt = Base64.encode64(OpenSSL::Random.random_bytes(KEY_LENGTH / 8))
      user.salt = user.salt.strip
      user.iv = Base64.encode64(OpenSSL::Random.random_bytes(16))
      user.iv = user.iv.strip
    end
  end

  def encrypt_data(master_password)
    self.password = encrypt(password, master_password, salt, iv)
    self.description = encrypt(description, master_password, salt, iv)
  end

  def decrypt_data(master_password)
    [
      decrypt(password, master_password, salt, iv),
      decrypt(description, master_password, salt, iv),
    ]
  end
end
