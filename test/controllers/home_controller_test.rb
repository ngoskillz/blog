require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select "title", "Home | TinyNGO.com"
  end

  test "should get categories" do
    get :categories
    assert_response :success
    assert_select "title", "Categories | TinyNGO.com"
  end

  test "should get video" do
    get :video
    assert_response :success
    assert_select "title", "Video | TinyNGO.com"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | TinyNGO.com"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact | TinyNGO.com"
  end
end
