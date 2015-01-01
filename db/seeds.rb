# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tv_commedies_cat = Category.create(name: 'TV Commedies')
tv_dramas_cat = Category.create(name: 'TV Dramas')

bob= User.create(name: "Bob", email:"Bob@email.com", password:"bob12bob",admin: true)
alice=User.create(name: "Alice", email: "Alice@email.com", password: "123456")
tony = User.create(name: "Tony", email: "Tony@email.com", password: "123456")
jenny = User.create(name: "Jenny", email: "Jenny@email.com", password: "123456")
ruby = User.create(name: "Ruby", email: "Ruby@email.com", password: "123456")
music = User.create(name: "Music", email: "Music@email.com", password: "123456")

def upload_photo_by_carrierwave(video,video_photo)
  src = File.join(Rails.root, "public/uploads/#{video_photo}_small.jpg")
  src_file = File.new(src)
  video.small_cover = src_file
  src = File.join(Rails.root, "public/uploads/#{video_photo}_large.jpg")
  src_file = File.new(src)
  video.large_cover = src_file
  video.save 
end

monk = Video.create(title: "Monk", description: "Monk is an American comedy-drama detective mystery television series created by Andy Breckman and starring Tony Shalhoub as the eponymous character, Adrian Monk. ",small_cover: 'monk.jpg', large_cover: 'monk_large.jpg', category: tv_commedies_cat, youtube_url: "www.youtube.com/embed/08wVJETF7wY")
upload_photo_by_carrierwave(monk,"monk") 

family_guy = Video.create(title: "Family guy", description: "Family Guy is an American adult animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company. ",small_cover: 'family_guy.jpg', large_cover: 'family_guy.jpg', category: tv_commedies_cat, youtube_url: "www.youtube.com/embed/VjO_AMm794Q")
upload_photo_by_carrierwave(family_guy,"family_guy")

the_pursuit_of_happyness = Video.create(title: "The pursuit of happyness", description: "The Pursuit of Happyness is a 2006 American biographical drama film based on Chris Gardner's nearly one-year struggle with homelessness. ",small_cover: 'monk.jpg', large_cover: 'monk_large.jpg', category: tv_dramas_cat, youtube_url: "www.youtube.com/embed/DvtxOzO6OAE")
upload_photo_by_carrierwave(the_pursuit_of_happyness,"the_pursuit_of_happyness")

life_of_pi = Video.create(title: "Life of pi", description: "Life of Pi is a Canadian fantasy adventure novel by Yann Martel published in 2001. The protagonist, Piscine Molitor ″Pi″.",small_cover: 'family_guy.jpg', large_cover: 'family_guy.jpg', category: tv_dramas_cat, youtube_url: "www.youtube.com/embed/mZEZ35Fhvuc")
upload_photo_by_carrierwave(life_of_pi,"life_of_pi")

fight_club = Video.create(title: "Fight Club", description: "Fight Club is a 1999 film based on the 1996 novel of the same name by Chuck Palahniuk.",small_cover: 'monk.jpg', large_cover: 'monk_large.jpg', category: tv_dramas_cat, youtube_url: "www.youtube.com/embed/SUXWAEX2jlg")
upload_photo_by_carrierwave(fight_club, "fight_club")

twelve_angry_men = Video.create(title: "Twelve angry men", description: "Twelve Angry Men is a drama written by Reginald Rose concerning the jury of a homicide trial.",small_cover: 'family_guy.jpg', large_cover: 'family_guy.jpg', category: tv_commedies_cat, youtube_url: "www.youtube.com/embed/RelOJfFIyp8")
upload_photo_by_carrierwave(twelve_angry_men,"twelve_angry_men")

bighero = Video.create(title: "Big Hero 6", description: "The film tells the story of a young robotics prodigy named Hiro Hamada who forms a superhero team to combat a masked villain.",small_cover: 'monk.jpg', large_cover: 'monk_large.jpg', category: tv_commedies_cat, youtube_url: "www.youtube.com/embed/z3biFxZIJOQ")
upload_photo_by_carrierwave(bighero, "bighero6")

family_guy2 = Video.create(title: "Family guy", description: "Family Guy is an American adult animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company.",small_cover: 'family_guy.jpg', large_cover: 'family_guy.jpg', category: tv_dramas_cat, youtube_url: "www.youtube.com/embed/VjO_AMm794Q")
upload_photo_by_carrierwave(family_guy2, "family_guy")

futurama = Video.create(title: "Futurama", description: "Futurama is an American adult animated science fiction sitcom created by Matt Groening and developed by Groening and David X. ",small_cover: 'futurama.jpg', large_cover: 'futurama.jpg', category: tv_commedies_cat, youtube_url: "www.youtube.com/embed/aTLj0BdIfmA")
upload_photo_by_carrierwave(futurama,"futurama")

south_park = Video.create(title: "South Park", description: "South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network.",small_cover: 'south_park.jpg', large_cover: 'south_park.jpg', category: tv_dramas_cat, youtube_url: "www.youtube.com/embed/ebJSmhrUlbQ")
upload_photo_by_carrierwave(south_park,"south_park")



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
  Relationship.create(follower_id: element, leader_id: 1) unless element == 1
end

(1..6).to_a.each do |element|
  Relationship.create(follower_id: element, leader_id: 2) unless element == 2
end

(1..6).to_a.each do |element|
  Relationship.create(follower_id: element, leader_id: 3) unless element == 3
end

(1..6).to_a.each do |element|
  Relationship.create(follower_id: element, leader_id: 4) unless element == 4
end

(1..5).to_a.each do |element|
  Relationship.create(follower_id: element, leader_id: 5) unless element == 5
end

(1..6).to_a.each do |element|
  Relationship.create(follower_id: element, leader_id: 6) unless element == 6
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