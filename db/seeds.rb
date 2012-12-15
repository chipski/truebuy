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


top=Company.find_by_name("Reviews") || Company.create!(:name=>"Reviews")
bran=Brand.find_by_name("Baby Products") || Brand.create!(:name=>"Baby Products",:company_id=>top.id)
comp=Company.find_by_name("Graco") || Company.create!(:name=>"Graco")

cat1=Category.find_by_name("Travel Gear") || Category.create!(:name=>"Travel Gear")  
cat2=Category.find_by_name("Strollers") || Category.create!(:name=>"Strollers", :parent_id=>cat1.id)  
cat3=Category.find_by_name("Car Seats") || Category.create!(:name=>"Car Seats", :parent_id=>cat1.id)  
cat4=Category.find_by_name("Toys") || Category.create!(:name=>"Toys")  

comp.categories << [cat1,cat2,cat3,cat4]
bran.categories << [cat1,cat2,cat3,cat4]
comp.categories << [cat1,cat2,cat3,cat4]

topic=Topic.create!(:name=>"Simple Browse") unless Topic.find_by_name("Simple Browse")
topic2=Topic.create!(:name=>"Lost & Found") unless Topic.find_by_name("Lost & Found")

