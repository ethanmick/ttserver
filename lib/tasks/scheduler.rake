desc "This task is called by the Heroku scheduler add-on"
task :update_feeds => :environment do
  puts "Updating feeds..."

  Feed.all.each do |f|
    f.update_feed
    puts "We now have #{f.entries.count} entries in #{f.title}"
  end

  puts "done."
end

# task :send_reminders => :environment do
#   User.send_reminders
# end
