require 'rake'
require 'feedzirra'
require 'open-uri'
require 'json'

namespace :update do
  
  desc "Expires events"
  task :expire => :environment do
    puts "expire events"
    Event.delete_all
  end

  desc "Update events from feeds"
  task :feeds => :environment do
    puts "update feeds"
    
    urls = [
      'http://illinois.edu/calendar/rss/3462.xml'
    ]

    urls.each do |url| 
      e = Feedzirra::Feed.fetch_and_parse(url).entries
      e.each do |ee|
        Event.create(
          title: ee.title,
          url: ee.url,
          time: Time.at(ee.published),
          description: ee.summary
        )
      end
    end
  end
  
  desc "Update meetup events"
  task :meetups => :environment do
    puts "update meetups"

    meetups = [
      'cuDBug',
      'Python-CU',
      'CU-Coffeeshop-Coders',
      'Bootstrappers-Breakfast-Champaign-Entrepreneurs-Meetup',
      'Central-Illinois-Drupal-Meetup',
      'UXBookClubCU'
    ]
    key = '1d27617672b7861562d3f700324572'

    e = {}
    meetups.each do |mu|
      url = "https://api.meetup.com/2/events?&key=#{key}&sign=true&time=-0w,12w&group_urlname=#{mu}"
      e = JSON.parse(open(url).read)
      e["results"].each do |ee|
        next if not ee["status"] == "upcoming"
        ee["duration"] ||= 3 * 60 * 60 * 1000
        ee["description"] ||= "No description of event provided."
        Event.create(
          title: ee["name"],
          url: ee["event_url"],
          time: Time.at(ee["time"] / 1000),
          duration: Time.at((ee["time"] + ee["duration"]) / 1000),
          description: ee["description"],
          group: ee["group"]["name"]
        )
      end
    end
  end
  
  desc "Update jobs"
  task :jobs  => :environment do
    puts "update jobs"
    Job.delete_all
    page = 0
    per_page = 20 # 25 is max!
    loop do
      start = page * per_page

url="http://api.indeed.com/ads/apisearch?format=json&publisher=6428770605442623&q=software+development&l=61820&sort=&radius=25&st=&jt=&start=#{start}&limit=#{per_page}&fromage=&filter=&latlong=1&co=us&chnl=&userip=&v=2"
      e = JSON.parse(open(url).read)
      e["results"].each do |ee|
        Job.create(
          title: ee['jobtitle'],
          company: ee['company'],
          listed: Time.parse(ee['date']),
          description: ee['snippet'],
          url: ee['url']
         )
      end
      break unless e['results'].size == per_page
      page += 1
    end
  end
  
  desc "Update events & jobs in db"
  task :all => [:environment, :expire, :feeds, :meetups, :jobs] do
    puts "db updated!"
  end
end
