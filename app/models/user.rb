class User < ActiveRecord::Base
  has_secure_password

  before_save { self.email = email.downcase }

  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  def generate_auth_token
    puts "==== in the generate_auth_token method ===="
    token = SecureRandom.hex
    puts "==== token generated: #{token}"
    self.update_columns(auth_token: token)
    puts "====== #{self.errors.full_messages}"
    puts "==== updated column"
    token
  end

  def invalidate_token
    self.update_columns(auth_token: nil)
  end

end
