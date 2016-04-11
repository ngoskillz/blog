# Learnings, after refactor
# User Roles for the blog
user_roles = ['user', 'moderator', 'banned', 'editor', 'admin']

# Setup arrays and initialize counts
usernames = []
email_addresses = []
role_count = 1 # role_ids are 1 user, 2 moderator, 3 banned, 4 editor, 5 admin 
name_index = 0
email_index = 0

user_roles.each do |role|
  Role.find_or_create_by({name: role}) # Create the role types in the database
  # Generate usernames and email addresses
  names = "mike" + role
  puts "Created Name"
  usernames.push(names)
  emails = usernames[name_index] + "@salmonellaville.com"
  puts "Created emails"
  email_addresses.push(emails)
  # Generate users and assign roles
  seed_user = User.create(username: usernames[name_index],
                          email: email_addresses[email_index],
                          password: ENV['SEED_USER_PASSWORD'])
  puts "Created User"
  seed_user.role_id = role_count
  seed_user.save
  puts "Associated role to user"
  # Increment counts and index for the next user
  role_count = role_count + 1
  name_index = name_index + 1
  email_index = email_index + 1
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

