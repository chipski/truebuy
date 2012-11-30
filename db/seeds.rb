# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'SETTING UP DEFAULT USER LOGIN'
def recreate_user(email, name="", admin=false)
  user = User.find_by_email(email)
  if user
    user.update_attribute(:password, "please")
    puts 'Existing user updated: ' << user.name
  else
    user = User.create!(:name=>name, :email=>email, :password=>'please', :password_confirmation=>'please')
    puts 'New user created: ' << user.name
  end
  user.confirm! 
  user.add_role :admin if admin
end

u1=recreate_user('chipski@mac.com', "Chip Vanek", true)
u2=recreate_user('chipski@me.com', "Chip Vanek")

comp=Company.create!(:name=>"Rightby.me") unless Company.find_by_name("Rightby.me")

