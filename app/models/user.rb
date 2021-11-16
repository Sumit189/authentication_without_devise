class User < ApplicationRecord
  attr_accessor :password_
  before_save :encrypt_password
  has_one_attached :image, dependent: :purge
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :email, presence: true, uniqueness: true
  # validates :password, presence: true, length: { minimum: 6 }
  # validates :password_confirmation, presence: true


  def authenticate(email, user_pass)
    user = User.find_by(email: email)
    if user and valid_user?(user_pass)
      return user
    end
  end

  def valid_user?(pass)
    self.password == encrypt(pass)
  end

  private
  def encrypt_password
    if self.password_.present?
      self.password = encrypt(self.password_)
    end
  end

  def encrypt(pass)
    Digest::SHA1.hexdigest(pass)
  end
end
