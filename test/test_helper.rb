ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActionController::TestCase
  include Devise::TestHelpers
end

# def setup
  # @admin_user = User.create(username: "testadmin", email: "testadmin@fortests.com", password: ENV['SEED_USER_PASSWORD'])
  # @admin_user.role_id = 5
  # @admin_user.save
  # @admin_user
# end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
