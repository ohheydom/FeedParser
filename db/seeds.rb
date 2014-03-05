arr = [
  ['MetsBlog', 'http://metsblog.com/feed/'],
  ['Amazin Avenue', 'http://www.amazinavenue.com/rss/current'],
  ['New York Mets Homepage News', 'http://mlb.mlb.com/partnerxml/gen/news/rss/nym.xml'],
  ['Mets Merized Online', 'http://metsmerizedonline.com/feed/'],
  ['Faith and Fear In Flushing', 'http://www.faithandfearinflushing.com/feed/']
      ]

arr.each { |title, url| Feed.create(title: title, url: url) }
