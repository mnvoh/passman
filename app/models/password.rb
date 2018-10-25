require 'openssl'
require 'base64'

class Password < ApplicationRecord
  KEY_LENGTH = 256
  KEY_ITER = 20000
  FORMAT_STRING = ":aes#{KEY_LENGTH}b64:"

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

  def encrypt_password(master_password)
    if /^#{FORMAT_STRING}/.match?(password)
      return
    end

    cipher = OpenSSL::Cipher::AES.new(KEY_LENGTH, :CBC)
    cipher.encrypt
    cipher.key = master_key(master_password)
    cipher.iv = Base64.decode64(iv)

    self.password = FORMAT_STRING +
      Base64.encode64(cipher.update(password) + cipher.final).strip
  end

  def decrypt_password(master_password)
    unless /^#{FORMAT_STRING}/.match?(password)
      return
    end

    decipher = OpenSSL::Cipher::AES.new(KEY_LENGTH, :CBC)
    decipher.decrypt
    decipher.key = master_key(master_password)
    decipher.iv = Base64.decode64(iv)

    raw_password = Base64.decode64(password.sub(FORMAT_STRING, ''))
    begin
      decipher.update(raw_password) + decipher.final
    rescue
      # wrong password, just return nil
    end
  end

  def master_key(master_password)
    OpenSSL::PKCS5.pbkdf2_hmac_sha1(
      master_password,
      Base64.decode64(salt),
      KEY_ITER,
      KEY_LENGTH / 8
    )
  end
end
