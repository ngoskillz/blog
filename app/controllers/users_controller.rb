class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => :show

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

  private

  def admin_only
    unless current_user.role.name == "admin"
      redirect_to :back, :alert => "Access denied."
    end
  end

  def change_user_role(selected_role)
    if current_user.role.name == "admin"
      new_role_id = new_role(selected_role)
      current_user.role_id = new_role_id
      current_user.save
    else
      redirect_to :back, :alert => "Access denied."
    end
  end

  def new_role(selected_role)
    if selected_role == "user"
      new_role_id = 1
    elsif selected_role == "moderator"
      new_role_id = 2
    elsif selected_role == "banned"
      new_role_id = 3
    elsif selected_role == "editor"
      new_role_id = 4
    elsif selected_role == "admin"
      new_role_id = 5
    end
    return new_role_id
  end

  def secure_params
    params.require(:user).permit(:role)
  end

end