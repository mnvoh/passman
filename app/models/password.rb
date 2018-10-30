require 'openssl'
require 'base64'

class Password < ApplicationRecord
  include Security

  before_save do |password|
    unless /^#{ENCRYPTED_DATA_HEADER}/.match?(password.password)
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
    new_password = encrypt(password, master_password, salt, iv)
    if new_password != password
      self.password_updated_at = DateTime.now
    end
    self.password = new_password
    self.description = encrypt(description, master_password, salt, iv)
    nil
  end

  def decrypt_data(master_password)
    [
      decrypt(password, master_password, salt, iv),
      decrypt(description, master_password, salt, iv),
    ]
  end
end
