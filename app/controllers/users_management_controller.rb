class UsersManagementController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user.attributes = params[:user]
    @user.role_ids = params[:user][:role_ids] if params[:user]
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
        format.html { redirect_to admin_users_path, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
        format.html { render :action => "new"}
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
    end
 
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_users_path, :notice => 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :ok }
    end
  end

  def _form
  end

  private

  def admin_only
    unless current_user.role_id == 5
    # unless current_user.role.name == "admin"
      redirect_to :root, :alert => "Access denied."
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
