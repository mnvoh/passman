require 'openssl'
require 'base64'
require 'securerandom'

module Security
  KEY_LENGTH = 256
  KEY_ITER = 20000
  ENCRYPTED_DATA_HEADER = ":aes#{KEY_LENGTH}b64:"
  LOWERCASE_CHARS = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
  UPPERCASE_CHARS = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
  NUMBERS = %w(0 1 2 3 4 5 6 7 8 9)
  SYMBOLS = %w(! @ # $ % ^ & *)

  def random(
    length,
    lowercase = true,
    uppercase = true,
    numbers = true,
    symbols = true
  )
    if length.to_i <= 0
      raise 'Length must be a positive integer'
    end
    
    charset = []
    charset += LOWERCASE_CHARS if lowercase
    charset += UPPERCASE_CHARS if uppercase
    charset += NUMBERS if numbers
    charset += SYMBOLS if symbols

    result = ""
    while result.length < length.to_i
      result += charset[SecureRandom.random_number(charset.length)]
    end

    result
  end

  def encrypt(data, psk, salt, iv)
    if /^#{ENCRYPTED_DATA_HEADER}/.match?(data)
      return data
    end

    if psk.nil? || psk.empty?
      return nil
    end

    cipher = OpenSSL::Cipher::AES.new(KEY_LENGTH, :CBC)
    cipher.encrypt
    cipher.key = psk_to_key(psk, salt)
    cipher.iv = Base64.decode64(iv)

    result = ENCRYPTED_DATA_HEADER + Base64.encode64(
      cipher.update(data) + cipher.final
    ).strip

    result
  end

  def decrypt(data, psk, salt, iv)
    unless /^#{ENCRYPTED_DATA_HEADER}/.match?(data)
      return data
    end

    decipher = OpenSSL::Cipher::AES.new(KEY_LENGTH, :CBC)
    decipher.decrypt
    decipher.key = psk_to_key(psk, salt)
    decipher.iv = Base64.decode64(iv)

    data = Base64.decode64(data.sub(ENCRYPTED_DATA_HEADER, ''))
    begin
      result = decipher.update(data) + decipher.final
    rescue
      # wrong password, just return nil
    end

    result
  end

  private

    def psk_to_key(psk, salt)
      OpenSSL::PKCS5.pbkdf2_hmac_sha1(
        psk,
        Base64.decode64(salt),
        KEY_ITER,
        KEY_LENGTH / 8
      )
    end
end
