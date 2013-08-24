# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'joe@castanet.com', password: Devise.friendly_token[0,20], role_list: 'superadmin')

Page.create(title: "History of C.O.D.E", url: '/', content: "          <h2 id=\"what-is-code\">What is CODE?</h2>\r\n\r\n<p>Many members of the group may not know the history of CODE. In brief… The\r\nclosure of Motorola’s Champaign site in 2007 dumped 200+ tech professionals\r\ninto the local job market. We knew that this was more than the community\r\ncould absorb, so a group of employees got together to attract businesses to\r\nthe area. Through their efforts and coordination with other local\r\norganizations, Yahoo! and Qualcomm sites were opened. Since then, we have\r\nhelped to attract other companies and to spawn projects to benefit the local\r\ntech community.</p>\r\n\r\n<p>A small group of people constitute the current CODE board. These are not\r\nelected positions. The leaders are volunteer who have the drive and passion\r\nfor developing the community at their own time and expense. We meet\r\ninformally with local organizations and coordinate mostly through email.\r\n(Personally, I would like a slightly more formal organization.)</p>\r\n\r\n<p>Mostly, the CODE board is an influencing organization. We have no income, but\r\nwe have lots of contacts with local and remote businesses, organizations, and\r\nindividuals.</p>\r\n\r\n<p>Our projects include:</p>\r\n\r\n<ul>\r\n  <li>working with the EDC on a central community job board;</li>\r\n  <li>discussions with Parkland about starting a Mobile Development Certificate program;</li>\r\n  <li>meeting with the U of I to help them understand the needs of local business and to help make hiring from the University more accessible for medium or small business.</li>\r\n</ul>\r\n\r\n<p>We have worked on or discussed many other projects, but we are constrained\r\nby the number of volunteers we have.</p>\r\n\r\n<p>Regarding meetings… We have discussed having quarterly, or even monthly,\r\nmeetings and events of various types for the technical community. The EDC\r\nalready sponsors regular TechMixes. (One was held yesterday evening.) Most\r\nlikely, I think that the first set of open meetings for CODE should be\r\nquarterly meetings to discuss the needs of the technical community and how we\r\ncan act to push those items forward.</p>\r\n\r\n<p>We would gladly be a conduit for helping to advertise meetings on technical\r\ntopics, but we would need someone from the community to volunteer to lead and\r\norganize the meeting. Our current volunteers are at capacity.</p>\r\n\r\n<p>If anyone would like to volunteer to assist in any capacity, we would welcome\r\ntheir help.</p>\r\n")

 
o = Organization.new(
  name: 'Champaign Organization of Developers and Engineers',
  synopsis: '<p>Promoting a stronger Tech Community through corporate/personnel recruitment, management of a community tech information portal and the support of community/social organizations.</p>',
  status: 'published',
  website: 'http://cucode.org',
  submitter_name: 'Joe Pickert',
  submitter_email: 'joe@castanet.com'
)
o.contacts.build(name: 'Joe Pickert')
o.contacts.build(name: 'Wes Cravens')
o.contacts.build(name: 'Ken Taylor')
o.contacts.build(name: 'Ross Bundy')
o.contacts.build(name: 'Terry Wong')
o.save!
  
o = Organization.new(
  name: 'Py-CU',
  synopsis: 'Champaign-Urbana\'s Python User Group.',
  status: 'published',
  website: 'http://py-cu.org',
  email: 'info@py-cu.org',
  submitter_name: 'Joe Pickert',
  submitter_email: 'joe@castanet.com'
)
o.contacts.build(name: 'Liz Surbeck')
o.contacts.build(name: 'Nadia Karlinsky')
o.save!

o = Organization.new(
  name: 'UX Book Club of Champaign-Urbana',
  synopsis: '<p>Fostering knowledge sharing and networking among area designers and developers interested in user experience, information architecture, web design, mobile design, usability, content strategy, research, wireframing, and prototyping.</p>
  
  <p>Events: We host monthly gatherings to discuss a UX-related book or a group of articles. Conversations often run far afield of the book but are always interesting. You do not have to have read the book to attend and join in.</p>',
  status: 'published',
  submitter_name: 'Joe Pickert',
  submitter_email: 'joe@castanet.com'
)
o.contacts.build(name: 'Liz Surbeck')
o.contacts.build(name: 'Nadia Karlinsky')
o.save!

o = Organization.new(
  name: 'Champaign Urbana Database Users Group',
  synopsis: '<p>cuDBug is a forum for those in the Champaign-Urbana region interested in the practice of database management. The group facilitates both professional networking and provides opportunities to hear from speakers on database management system topics of interest. cuDBug aims to meet every other month in the University of Illinois Research Park or nearby.</p>
  
  <p>Events: Guest speakers covering various topics related to database management, design, & use.</p>',
  status: 'published',
  submitter_name: 'Joe Pickert',
  submitter_email: 'joe@castanet.com'
)
o.contacts.build(name: 'Charles Linville')
o.save!

o = Organization.new(
  name: 'CU Coffee Shop Coders',
  synopsis: '<p>Do you love to write code? Have a pet project that you\'ve been itching to work on? Want to meet other programmers outside your normal environment? So do we! Whether you are a seasoned developer looking for a place to work on side projects, or diving into your first app, it doesn\'t matter. Bring your laptop, an open mind, and come have fun.</p>',
  status: 'published',
  submitter_name: 'Joe Pickert',
  submitter_email: 'joe@castanet.com'
)
o.contacts.build(name: 'Cameron Macintosh')
o.save!

o = Organization.new(
  name: 'University of Illinois Webmasters',
  synopsis: '<p>The University of Illinois Webmasters is an open community of web professionals dedicated to sharing ideas and promoting dialogue through various channels, such as our Web site, listserv, workshops, presentations, and annual University of Illinois Web Conference, just to name a few. Getting involved with the Webmasters is easy. There are no fees or long forms to fill out. To get involved, simply subscribe to one of our feeds, or attend/present at one of our events. The Webmasters is a great way to learn about the Web and network.</p>',
  status: 'published',
  website: 'http://webmasters.illinois.edu/',
  submitter_name: 'Joe Pickert',
  submitter_email: 'joe@castanet.com'
)
o.save!

o = Organization.new(
  name: 'The Champaign-Urbana Design Organization (CUDO)',
  synopsis: '<p>TCUDO was founded in early 2009 by a group of local designers who were eager to meet others who shared their passion for design. While CUDO started as a professional organization for graphic designers, it has since evolved to be a far more inclusive organization for everyone who loves design, whether you are a professional, student, or avid fan (aka design nerd). CUDO’s mission is to cultivate a vibrant design culture that engages and enriches our local community.</p>',
  status: 'published',
  website: 'http://thecudo.org/',
  submitter_name: 'Joe Pickert',
  submitter_email: 'joe@castanet.com'
)
o.save!

`rake update:all`

if Rails.env == 'development'
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
end
