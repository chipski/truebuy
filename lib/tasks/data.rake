namespace :data do
  
  desc "Dump Production DB as prep"
  task :get_prod_db do
    puts "Dumping Truebuy DB to local machine"
    system "curl -o tmp/truebuy.sql `heroku pgbackups:url` "
    puts "Created new mysqldump in tmp off app root"
  end

  desc "Dump Local DB as prep"
  task :dump_db do
    puts "Dumping Truebuy DB from local machine"
    system "mysqldump --user=root --password= rightbyme_development > tmp/rightbyme_development.sql "
    puts "Dumped rightbyme_development in tmp off app root"
  end
  
  desc "Restore DB from production to local machine"
  task :restore_db do
    file_name = "#{Date.today.strftime("%Y_%m_%d")}_04.sql.gz"
    puts "Restoring Production Groupiter DB #{file_name} to local machine"
    system "scp -P 9722 deploy@redis.groupiter.com:~/DB_Backup/production/daily/#{file_name} /tmp/production.sql.gz"
    puts "Copied database dump #{file_name} to /tmp/production.sql.gz"
    system "gunzip /tmp/production.sql.gz"
    system "mysql -u root --password='' -e 'drop database if exists groupiter_development'"
    system "mysql -u root --password='' -e 'create database groupiter_development'"
    puts "Dropped your local db and created empty db, loading production.sql now"
    system "mysql -u root --password='' groupiter_development < /tmp/production.sql"
    puts "All done running db:migrate just for kicks"
    system "rake db:migrate"
  end
  
end