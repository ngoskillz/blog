class User < ActiveRecord::Base
  # set up a controller with user authentication
  # before_action :authenticate_user!

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #       :confirmable, :lockable, :timeoutable, :omniauthable
end
