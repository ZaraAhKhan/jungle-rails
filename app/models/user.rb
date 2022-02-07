class User < ActiveRecord::Base

  def self.authenticate_with_credentials (email,password) 
    email.strip!
    email.downcase!
    @user = User.find_by_email(email)
    if @user && @user.authenticate(password) 
      return @user
    else
      return nil
    end
  end

  has_secure_password
  validates_uniqueness_of :email, :case_sensitive => false
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  before_save :downcase_fields

  validates :password,length: { minimum:5 }
  def downcase_fields
    self.email.downcase!
  end
end
