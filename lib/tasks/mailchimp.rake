namespace :mail_chimp do

  desc "Run MailChimp sync task"
  task :sync  => :environment do
    
    hours_ago = ENV['hours_ago'] || 1
    
    puts ""
    puts "===> Getting Users updated in the last #{hours_ago} hours and syncing to MailChimp"
        
    mc=Apis::MailChimp.new
    mc.sync_all(hours_ago.to_f)

  end
  desc "Run MailChimp sync all task"
  task :sync_all  => :environment do
    
    hours_ago = ENV['hours_ago'] || 888
    
    puts ""
    puts "===> Getting Users updated in the last #{hours_ago} hours and syncing to MailChimp"
        
    mc=Apis::MailChimp.new
    mc.sync_all(hours_ago.to_f, true)

  end

end