require 'bcrypt'

class User < ApplicationRecord
  validates_uniqueness_of :name, case_sensitive: false

  def password=(password)
    self.password_hash = BCrypt::Engine.hash_secret(password, '$2a$10$WwIq1tQTEKW6kb9T5OMiE.')
  end

  def log_in(password)
    # Constant salt
    BCrypt::Engine.hash_secret(password, '$2a$10$WwIq1tQTEKW6kb9T5OMiE.') == self.password_hash
  end
end
