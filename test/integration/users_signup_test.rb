require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post users_path, user: { username:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template "devise/shared/_links"
    assert_template "devise/registrations/new"
    assert_template "devise/shared/_navbar"
    assert_template "layouts/_footer"
    assert_template "layouts/application"
  end

  test "valid signup information" do
    get new_user_registration_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { username:  "ExampleUser",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    assert_template "home/index"
    assert_template "devise/shared/_navbar"
    assert_template "layouts/_footer"
    assert_template "layouts/application"
  end
end
