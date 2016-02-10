# User Roles for the blog
user_roles = ['user', 'moderator', 'banned', 'editor', 'admin']

# Learnings, after refactor
usernames = []
email_addresses = []
user_roles.each do |role|
  Role.find_or_create_by({name: role})            # Create the role types in the database
  names = "mike" + user_roles[i]                  # Generate a username for each role
  usernames.push(names)
  emails = usernames[i] + "@salmonellaville.com"  # Generate the email addresses based on username
  email_addresses.push(emails)

  role_count = i + 1                              # Generate users and assign roles
  seed_user = User.create(username: usernames[i], email: email_addresses[i], password: "iloveyammer")
  seed_user.role_id = role_count
  seed_user.save
end

# # Learnings, before refactor
# user_roles.each do |role|
#   Role.find_or_create_by({name: role})
# end

# # Dynamically generate a username for each role
# usernames = []
# for i in 0..user_roles.length-1
#   names = "mike" + user_roles[i]
#   usernames.push(names)
# end

# # Dynamically generate the email addresses based on username
# email_addresses = []
# for i in 0..usernames.length-1
#   emails = usernames[i] + "@salmonellaville.com"
#   email_addresses.push(emails)
# end

# # Dynamically generate users after creating roles, usernames, and email addresses
# for i in 0..user_roles.length-1
#   role_count = i + 1
#   seed_user = User.create(username: usernames[i], email: email_addresses[i], password: "iloveyammer")
#   seed_user.role_id = role_count
#   seed_user.save
# end

