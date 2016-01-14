class User < ActiveRecord::Base
  has_and_belongs_to_many :roles

  # set up a controller with user authentication
  # before_action :authenticate_user!

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #       :confirmable, :lockable, :timeoutable, :omniauthable

  def role?(role)
    return self.roles.find_by_name(role).try(:name) == role.to_s
  end
end
