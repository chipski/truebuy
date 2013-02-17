namespace :user_info do

  desc "Add default roles"
  task :add_roles  => :environment do
    puts "===> Adding default roles and setting users as default"
    Role.create([{:name=>:admin},{:name=>:customer},{:name=>:member},{:name=>:visitor}]) 
    User.all.map{|u| u.add_initial_role}
    
  end
  
end