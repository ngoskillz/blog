class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :admin_only, :except => :show

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless current_user.role.name == "admin"
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      # redirect_to users_path, :notice => "User updated."
      redirect_to users_path, flash[:success] => "Profile updated."
    else
      # redirect_to users_path, :alert => "Unable to update user."
      redirect_to users_path, flash[:failure] => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end
end