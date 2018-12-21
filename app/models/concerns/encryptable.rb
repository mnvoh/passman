module Encryptable
  extend ActiveSupport::Concern
  include Security

  included do
    after_initialize -> { prepare_cipher }
  end

  private

    def prepare_cipher
      if salt.nil? || iv.nil?
        self.salt = Base64.encode64(
          OpenSSL::Random.random_bytes(KEY_LENGTH / 8)
        ).strip
        self.iv = Base64.encode64(OpenSSL::Random.random_bytes(16)).strip
      end
    end
end
