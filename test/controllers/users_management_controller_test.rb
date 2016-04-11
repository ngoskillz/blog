require 'test_helper'
require 'devise'

class UsersManagementControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    user_roles = ['user', 'moderator', 'banned', 'editor', 'admin']
    user_roles.each do |role|
      Role.find_or_create_by({name: role})
    end
    # @user = User.create(username: "mikeadmin",
    #                     email: "mikeadmin@testerville.com",
    #                     password: "unittester")
    # @user.role_id = 5
    # @user.save
    @user = users(:derp)
    sign_in @user
    # @user = users(:one)
    # puts @user.role.name
  end

  test "should get _form" do
    get :_form
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "title", "All users | TinyNGO.com"
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end
end
