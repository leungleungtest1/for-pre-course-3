require 'spec_helper'
describe Category do
  it { should have_many(:videos)}
  it "has many video" do
      cat = Category.create(name: "DJ god you")
      music_video = Video.create(title: "Music Video", description: "It is a MV" ,category: cat)
      total_war = Video.create(title: "Total war", description: "It is my favourite.",category: cat)
      expect(cat.videos).to eq([music_video, total_war])
  end
  
  describe "recent_videos" do
      it "will give an empty array if the category does not have a video." do
        family_cat = Category.create(name: 'family', created_at: 10.day.ago)
        commodies_cat = Category.create(name: 'Commodies', created_at: 11.day.ago)
        dinosaur1 = Video.create(title:"dinosaur", description: "Tasty dinosaur1", category: family_cat, created_at: 1.day.ago)
        dinosaur2 = Video.create(title:"dinosaur", description: "Tasty dinosaur2", category: family_cat, created_at: 2.day.ago)
        dinosaur3 = Video.create(title:"dinosaur", description: "Tasty dinosaur3" , category: family_cat, created_at: 3.day.ago)
        dinosaur4 = Video.create(title:"dinosaur", description: "Tasty dinosaur4" , category: family_cat, created_at: 3.day.ago)
        dinosaur5 = Video.create(title:"dinosaur", description: "Tasty dinosaur5" , category: family_cat, created_at: 3.day.ago)
        dinosaur6 = Video.create(title:"dinosaur", description: "Tasty dinosaur6" , category: family_cat, created_at: 3.day.ago)
        assassin = Video.create(title: 'assassin', description: 'Assassin is a way to strive.', category: family_cat, created_at: 4.day.ago)
        expect(commodies_cat.recent_videos).to eq([])
      end
      it "will give an array of all vidoes if the category's videos is less than or equal to six." do
        family_cat = Category.create(name: 'family', created_at: 10.day.ago)
        commodies_cat = Category.create(name: 'Commodies', created_at: 11.day.ago)
        dinosaur1 = Video.create(title:"dinosaur", description: "Tasty dinosaur1", category: family_cat, created_at: 1.day.ago)
        dinosaur2 = Video.create(title:"dinosaur", description: "Tasty dinosaur2", category: family_cat, created_at: 2.day.ago)
        dinosaur3 = Video.create(title:"dinosaur", description: "Tasty dinosaur3" , category: family_cat, created_at: 3.day.ago)
        dinosaur4 = Video.create(title:"dinosaur", description: "Tasty dinosaur4" , category: family_cat, created_at: 3.day.ago)
        dinosaur5 = Video.create(title:"dinosaur", description: "Tasty dinosaur5" , category: family_cat, created_at: 3.day.ago)
        dinosaur6 = Video.create(title:"dinosaur", description: "Tasty dinosaur6" , category: family_cat, created_at: 3.day.ago)
        assassin = Video.create(title: 'assassin', description: 'Assassin is a way to strive.', category: family_cat, created_at: 4.day.ago)
        total_war = Video.create(title: "Total war", description: "The strategy game ...", category: commodies_cat, created_at: 30.day.ago)
        expect(commodies_cat.recent_videos).to eq([total_war])
        #expect(commodies_cat.recent_videos).to eq([dinosaur6,dinosaur5, dinosaur4, dinosaur3,dinosaur2,dinosaur1])
      end
      it "will give an array of the most recent six videos ordered by created_at from the specific category." do 
        family_cat = Category.create(name: 'family', created_at: 10.day.ago)
        commodies_cat = Category.create(name: 'Commodies', created_at: 11.day.ago)
        dinosaur1 = Video.create(title:"dinosaur", description: "Tasty dinosaur1", url_small_cover: "http://static.guim.co.uk/sys-images/Film/Pix/pictures/2001/06/05/jurassic2.jpg" ,url_large_cover: "http://pmcdeadline2.files.wordpress.com/2013/01/jurassicpark__130111230212.jpg",category: family_cat, created_at: 10.day.ago)
        dinosaur2 = Video.create(title:"dinosaur", description: "Tasty dinosaur2", url_small_cover: "http://static.guim.co.uk/sys-images/Film/Pix/pictures/2001/06/05/jurassic2.jpg" ,url_large_cover: "http://pmcdeadline2.files.wordpress.com/2013/01/jurassicpark__130111230212.jpg",category: family_cat, created_at: 9.day.ago)
        dinosaur3 = Video.create(title:"dinosaur", description: "Tasty dinosaur3", url_small_cover: "http://static.guim.co.uk/sys-images/Film/Pix/pictures/2001/06/05/jurassic2.jpg" ,url_large_cover: "http://pmcdeadline2.files.wordpress.com/2013/01/jurassicpark__130111230212.jpg",category: family_cat, created_at: 8.day.ago)
        dinosaur4 = Video.create(title:"dinosaur", description: "Tasty dinosaur4", url_small_cover: "http://static.guim.co.uk/sys-images/Film/Pix/pictures/2001/06/05/jurassic2.jpg" ,url_large_cover: "http://pmcdeadline2.files.wordpress.com/2013/01/jurassicpark__130111230212.jpg",category: family_cat, created_at: 7.day.ago)
        dinosaur5 = Video.create(title:"dinosaur", description: "Tasty dinosaur5", url_small_cover: "http://static.guim.co.uk/sys-images/Film/Pix/pictures/2001/06/05/jurassic2.jpg" , url_large_cover: "http://pmcdeadline2.files.wordpress.com/2013/01/jurassicpark__130111230212.jpg",category: family_cat, created_at: 6.day.ago)
        dinosaur6 = Video.create(title:"dinosaur", description: "Tasty dinosaur6", url_small_cover: "http://static.guim.co.uk/sys-images/Film/Pix/pictures/2001/06/05/jurassic2.jpg" ,url_large_cover: "http://pmcdeadline2.files.wordpress.com/2013/01/jurassicpark__130111230212.jpg",category: family_cat, created_at: 5.day.ago)
        assassin = Video.create(title: 'assassin', description: 'Assassin is a way to strive.', category: family_cat, created_at: 4.day.ago)
        total_war = Video.create(title: "Total war", description: "The strategy game ...", category: commodies_cat, created_at: 30.day.ago)
        expect(family_cat.recent_videos).to eq([assassin,dinosaur6,dinosaur5, dinosaur4, dinosaur3,dinosaur2])
      end
  
  end


end