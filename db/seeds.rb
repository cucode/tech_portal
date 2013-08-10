# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def randomname
  Random.firstname + ' ' + Random.lastname
end

def neworg(contacts)
  o = Organization.new(
   name: Random.paragraphs(3).split[0...(5..9).to_a.sample].join(' '),
   synopsis: Random.paragraphs((5..9).to_a.sample),
   email: Random.email,
   phone: Random.phone,
   status: "published",
   submitter_name: randomname,
   submitter_email: Random.email,
   submitter_phone: Random.phone
  )
  contacts.times {
    o.contacts.build(
      name: randomname,
      title: Random.paragraphs(3).split[0...(1..3).to_a.sample].join(' '),
      email: Random.email,
      phone: Random.phone
    )
  }
  o.save
  if o.errors.any?
    pp o.errors
  end
end

30.times {neworg((1..4).to_a.sample)}