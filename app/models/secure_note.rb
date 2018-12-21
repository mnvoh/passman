class SecureNote < ApplicationRecord
  include Security
  include Encryptable

  before_save do |secure_note|
    unless /^#{ENCRYPTED_DATA_HEADER}/.match?(secure_note.note)
      raise 'Attempting to save plain text note! Call `encrypt`' +
        ' with a master password first.'
    end
    note = '' if note.nil?
  end

  def encrypt_note(master_password)
    new_note = encrypt(note, master_password, salt, iv)
    self.note = new_note
    nil
  end

  def decrypt_note(master_password)
    decrypted_note = decrypt(note, master_password, salt, iv)
    decrypted_note = '' unless self.note.present?
    decrypted_note
  end
end
