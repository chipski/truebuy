# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'SETTING UP DEFAULT USER LOGIN'
Role.create([{:name=>:admin},{:name=>:customer},{:name=>:member},{:name=>:visitor}]) 

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


top=Company.find_by_name("TrueBuy") || Company.create!(:name=>"TrueBuy", :state=>"active", :permalink=>"truebuy")
bran=Brand.find_by_name("Baby Products") || Brand.create!(:name=>"Baby Products",:company_id=>top.id, :state=>"active")
comp=Company.find_by_name("Graco") || Company.create!(:name=>"Graco")

cat1=Category.find_by_name("Travel Gear") || Category.create!(:name=>"Travel Gear", :state=>"active")  
cat2=Category.find_by_name("Strollers") || Category.create!(:name=>"Strollers", :parent_id=>cat1.id, :state=>"active")  
cat3=Category.find_by_name("Car Seats") || Category.create!(:name=>"Car Seats", :parent_id=>cat1.id, :state=>"active")  
cat4=Category.find_by_name("Toys") || Category.create!(:name=>"Toys")  

top.categories << [cat1,cat2,cat3,cat4]
top.save
bran.categories << [cat1,cat2,cat3,cat4]
bran.save
comp.categories << [cat1,cat2,cat3,cat4]
comp.save

topic=Topic.find_by_name("Simple Browse") || Topic.create!(:name=>"Simple Browse", :state=>"active")  
topic2=Topic.find_by_name("Lost & Found") || Topic.create!(:name=>"Lost & Found", :state=>"active")

about=Topic.find_by_permalink("about") || Topic.create!(:name=>"About Us", :permalink=>"about", :company_id=>top.id,:state=>"list_only")
tos=Topic.find_by_permalink("tos") || Topic.create!(:name=>"Terms of Service", :permalink=>"tos", :company_id=>top.id, :state=>"list_only")
privacy=Topic.find_by_permalink("privacy") || Topic.create!(:name=>"Privacy Policy", :permalink=>"privacy", :company_id=>top.id, :state=>"list_only")

