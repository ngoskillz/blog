class User < ActiveRecord::Base
  belongs_to :role
  attr_accessor :login
  before_create :set_default_role
  has_many :comment

  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]
  #       :confirmable, :lockable, :timeoutable, :omniauthable

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  # Username validations
  validates :username,
  :presence => true,
  :length => { 
    :minimum => 4, 
    :maximum => 16 
  },
  :uniqueness => {
    :case_sensitive => false
  }

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  # Define user roles
  def role?(role)
    return self.role.name == role
  end

  # Default role is "User"
  def set_default_role
    self.role ||= Role.find_by_name('user')
  end

    # Define formatted email
  def formatted_email
    @name = username
    @email = email
    "#{@name} <#{@email}>"
  end
end
