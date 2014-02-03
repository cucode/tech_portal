desc "This task is called by the Heroku scheduler add-on"
task :import_events => :environment do
  puts "Updating event feeds..."
  `curl --data "cron_token=#{ENV['CRON_TOKEN']}" http://cucode-prd.herokuapp.com/events/import`
  puts "done."
end