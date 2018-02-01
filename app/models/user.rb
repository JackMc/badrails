require 'bcrypt'

class User < ApplicationRecord
  validates_uniqueness_of :name, case_sensitive: false

  def password=(password)
    self.password_hash = BCrypt::Engine.hash_secret(password, '$2a$10$WwIq1tQTEKW6kb9T5OMiE.')
  end

  def self.login(user, password)
    hash = BCrypt::Engine.hash_secret(password, '$2a$10$WwIq1tQTEKW6kb9T5OMiE.')

    User.where("password_hash = '#{hash}' AND name = '#{user}'").first
  end
end
