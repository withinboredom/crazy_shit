fixtures = () ->

if Projects.find().count() is 0
  Projects.insert
    title: 'Crazy Shit'
    url: 'withinboredom/crazy-shit'
    comment: 'indigo'
    user: 'withinboredom'
    slug: 'crazy-shit'

fixtures()