class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :passwords
  has_many :secure_notes

  def set_preferences(prefs)
    if preferences.nil?
      self.preferences = {}
    end

    prefs.each do |key, value|
      self.preferences[key.to_s] = value
    end
  end
end