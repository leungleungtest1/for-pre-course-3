# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Video.create(title: "Monk", description: "This is a monk story.", url_small_cover: 'tmp/monk.jpg', url_large_cover: 'tmp/monk_large.jpg')
Video.create(title: "Family_guy", description: "This is a Family_guy story", url_small_cover: 'tmp/family_guy', url_large_cover: 'tmp/family_guy')

Category.create(name: 'TV Commedies')
Category.create(name: 'TV Dramas')