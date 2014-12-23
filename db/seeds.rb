# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tv_commedies_cat = Category.create(name: 'TV Commedies')
tv_dramas_cat = Category.create(name: 'TV Dramas')

bob= User.create(name: "Bob", email:"Bob@email.com", password:"123456",admin: true)
alice=User.create(name: "Alice", email: "Alice@email.com", password: "123456")
tony = User.create(name: "Tony", email: "Tony@email.com", password: "123456")
jenny = User.create(name: "Jenny", email: "Jenny@email.com", password: "123456")
ruby = User.create(name: "Ruby", email: "Ruby@email.com", password: "123456")
music = User.create(name: "Music", email: "Music@email.com", password: "123456")
Video.create(title: "Monk", description: "This is a monk story.",small_cover: '/tmp/monk.jpg', large_cover: '/tmp/monk_large.jpg', category: tv_commedies_cat)
Video.create(title: "Family_guy", description: "This is a Family_guy story",small_cover: '/tmp/family_guy.jpg', large_cover: '/tmp/family_guy.jpg', category: tv_commedies_cat)
Video.create(title: "Monk", description: "This is a monk story.",small_cover: '/tmp/monk.jpg', large_cover: '/tmp/monk_large.jpg', category: tv_commedies_cat)
Video.create(title: "Family_guy", description: "This is a Family_guy story",small_cover: '/tmp/family_guy.jpg', large_cover: '/tmp/family_guy.jpg', category: tv_commedies_cat)
Video.create(title: "Monk", description: "This is a monk story.",small_cover: '/tmp/monk.jpg', large_cover: '/tmp/monk_large.jpg', category: tv_commedies_cat)
Video.create(title: "Family_guy", description: "This is a Family_guy story",small_cover: '/tmp/family_guy.jpg', large_cover: '/tmp/family_guy.jpg', category: tv_commedies_cat)
Video.create(title: "Monk", description: "This is a monk story.",small_cover: '/tmp/monk.jpg', large_cover: '/tmp/monk_large.jpg', category: tv_commedies_cat)
Video.create(title: "Family_guy", description: "This is a Family_guy story",small_cover: '/tmp/family_guy.jpg', large_cover: '/tmp/family_guy.jpg', category: tv_dramas_cat)
Video.create(title: "Futurama", description: "This is a future story.",small_cover: '/tmp/futurama.jpg', large_cover: '/tmp/futurama.jpg', category: tv_commedies_cat)
Video.create(title: "South Park", description: "This is a south park story",small_cover: '/tmp/south_park.jpg', large_cover: '/tmp/south_park.jpg', category: tv_dramas_cat)

Review.create(description: "This is a good movie1", rating: 1, user_id: 1,video_id: 1)
Review.create(description: "This is a good movie2", rating: 3, user_id: 1,video_id: 1)
Review.create(description: "This is a good movie3", rating: 3, user_id: 1,video_id: 1)

Review.create(description: "This is a good movie1", rating: 1, user_id: 2,video_id: 2)
Review.create(description: "This is a good movie2", rating: 3, user_id: 3,video_id: 3)
Review.create(description: "This is a good movie3", rating: 3, user_id: 1,video_id: 4)

(1..4).to_a.each_with_index do |element, index|
  QueueItem.create(video_id:element, user: bob, position: index)
end
(1..5).to_a.each_with_index do |element, index|
  QueueItem.create(video_id:element, user: alice, position: index)
end

[2,3,5,6].each_with_index do |element, index|
  QueueItem.create(video_id:element, user: tony, position: index)
end

(1..5).to_a.each_with_index do |element, index|
  QueueItem.create(video_id:element, user: music, position: index)
end

(2..6).to_a.each do |element|
  Relationship.create(follower_id: element, leader_id: 2) unless element == 2
end

(2..6).to_a.each do |element|
  Relationship.create(follower_id: element, leader_id: 3) unless element == 3
end

(1..6).to_a.each do |element|
  Relationship.create(follower_id: element, leader_id: 4) unless element == 4
end

(1..5).to_a.each do |element|
  Relationship.create(follower_id: element, leader_id: 5) unless element == 5
end



#family_cat = Category.create(name: 'family', created_at: 10.day.ago)
#commodies_cat = Category.create(name: 'Commodies', created_at: 11.day.ago)
#dinosaur1 = Video.create(title:"dinosaur", description: "Tasty dinosaur1",small_cover: "http://static.guim.co.uk/sys-images/Film/Pix/pictures/2001/06/05/jurassic2.jpg" ,large_cover: "http://pmcdeadline2.files.wordpress.com/2013/01/jurassicpark__130111230212.jpg",category: family_cat, created_at: 10.day.ago)
#dinosaur2 = Video.create(title:"dinosaur", description: "Tasty dinosaur2",small_cover: "http://static.guim.co.uk/sys-images/Film/Pix/pictures/2001/06/05/jurassic2.jpg" ,large_cover: "http://pmcdeadline2.files.wordpress.com/2013/01/jurassicpark__130111230212.jpg",category: family_cat, created_at: 9.day.ago)
#dinosaur3 = Video.create(title:"dinosaur", description: "Tasty dinosaur3",small_cover: "http://static.guim.co.uk/sys-images/Film/Pix/pictures/2001/06/05/jurassic2.jpg" ,large_cover: "http://pmcdeadline2.files.wordpress.com/2013/01/jurassicpark__130111230212.jpg",category: family_cat, created_at: 8.day.ago)
#dinosaur4 = Video.create(title:"dinosaur", description: "Tasty dinosaur4",small_cover: "http://static.guim.co.uk/sys-images/Film/Pix/pictures/2001/06/05/jurassic2.jpg" ,large_cover: "http://pmcdeadline2.files.wordpress.com/2013/01/jurassicpark__130111230212.jpg",category: family_cat, created_at: 7.day.ago)
#dinosaur5 = Video.create(title:"dinosaur", description: "Tasty dinosaur5",small_cover: "http://static.guim.co.uk/sys-images/Film/Pix/pictures/2001/06/05/jurassic2.jpg" , large_cover: "http://pmcdeadline2.files.wordpress.com/2013/01/jurassicpark__130111230212.jpg",category: family_cat, created_at: 6.day.ago)
#dinosaur6 = Video.create(title:"dinosaur", description: "Tasty dinosaur6",small_cover: "http://static.guim.co.uk/sys-images/Film/Pix/pictures/2001/06/05/jurassic2.jpg" ,large_cover: "http://pmcdeadline2.files.wordpress.com/2013/01/jurassicpark__130111230212.jpg",category: family_cat, created_at: 5.day.ago)
#assassin = Video.create(title: 'assassin', description: 'Assassin is a way to strive.', category: family_cat, created_at: 4.day.ago)
#total_war = Video.create(title: "Total war", description: "The strategy game ...", category: commodies_cat, created_at: 30.day.ago)