# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_roles = ['user', 'moderator', 'banned', 'editor', 'admin']

user_roles.each do |role|
  Role.find_or_create_by({name: role})
end

# Dynamically generate a username for each role
usernames = []
for i in 0..user_roles.length-1
  names = "mike" + user_roles[i]
  usernames.push(names)
end

# Dynamically generate the email addresses based on username
email_addresses = []
for i in 0..usernames.length-1
  emails = usernames[i] + "@salmonellaville.com"
  email_addresses.push(emails)
end

# Dynamically generate users after creating roles, usernames, and email addresses
for i in 0..user_roles.length-1
  role_count = i + 1
  seed_user = User.create(username: usernames[i], email: email_addresses[i], password: "iloveyammer")
  seed_user.role_id = role_count
  seed_user.save
end

