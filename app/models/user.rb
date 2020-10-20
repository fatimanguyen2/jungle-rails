class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    email.strip!
    @user = User.where('lower(email) = ?', email.downcase).first 
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end
end
