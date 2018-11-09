require 'openssl'
require 'base64'
require 'zxcvbn'

class Password < ApplicationRecord
  include Security

  before_save do |password|
    unless /^#{ENCRYPTED_DATA_HEADER}/.match?(password.password)
      raise 'Attempting to save plain text password! Call `encrypt_password`' +
        ' with a master password first.'
    end
    password = '' if password.nil?
    description = '' if description.nil?
  end

  after_initialize do |user|
    if user.salt.nil? || user.iv.nil?
      user.salt = Base64.encode64(OpenSSL::Random.random_bytes(KEY_LENGTH / 8))
      user.salt = user.salt.strip
      user.iv = Base64.encode64(OpenSSL::Random.random_bytes(16))
      user.iv = user.iv.strip
    end
  end

  def domain
    begin
      u = self.url
      u = "http://#{u}" if URI.parse(u).scheme.nil?
      host = URI.parse(u).host.downcase
      host = host.start_with?('www.') ? host[4..-1] : host
    rescue
      # invalid url, so just return nil
    end
  end

  def encrypt_data(master_password)
    new_password = encrypt(password, master_password, salt, iv)
    if new_password != password
      self.password_strength = Zxcvbn.test(self.password).score
      self.password_updated_at = DateTime.now
    end
    self.password = new_password
    self.description = encrypt(description, master_password, salt, iv)
    nil
  end

  def decrypt_data(master_password)
    decrypted_pass = decrypt(password, master_password, salt, iv)
    decrypted_desc = decrypt(description, master_password, salt, iv)

    decrypted_pass = '' if self.password.nil? || self.password.empty?
    decrypted_desc = '' if self.description.nil? || self.description.empty?

    [decrypted_pass, decrypted_desc]
  end
end
