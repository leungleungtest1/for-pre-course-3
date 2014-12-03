require 'spec_helper'

describe Video do 
    it { should belong_to(:category)}
    it { should validate_presence_of(:title)}
    it { should validate_presence_of(:description)}
    describe "search_by_title" do
      before :each do
        @dinosaur1 = Video.create(title:"dinosaur", description: "Tasty dinosaur1", created_at: 1.day.ago)
        @dinosaur2 = Video.create(title:"dinosaur", description: "Tasty dinosaur2", created_at: 2.day.ago)
        @dinosaur3 = Video.create(title:"dinosaur", description: "Tasty dinosaur3" , created_at: 3.day.ago)
        @assassin = Video.create(title: 'assassin', description: 'Assassin is a way to strive.' , created_at: 4.day.ago)
      end
      it " returns an array of requied videos ordered by created_at if the videos of the title are present" do 
      
      expect(Video.search_by_title("dinosaur")).to eq([@dinosaur1,@dinosaur2,@dinosaur3])
      end
      it " returns an array of one videos if only one video of the title is present" do 

      expect(Video.search_by_title("assassin")).to eq([@assassin])
      end
      it " returns an array of one videos if only one video matched partially" do 

      expect(Video.search_by_title("assassin")).to eq([@assassin])
      end
      it "returns an empty array if the videos of the title are absent"do 

      expect(Video.search_by_title("no_title")).to eq([])
      end
      it "returns an empty array for a search with an empty string" do 

      expect(Video.search_by_title("")).to eq([])
      end
    end
    describe "average_rating" do
      before :each do
        @dinosaur1 = Video.create(title:"dinosaur", description: "Tasty dinosaur1", created_at: 1.day.ago)
      end
      it "return zero when video have no review" do
      expect(@dinosaur1.average_rating).to eq(0.0)
      end
      it "reutrn a number round to 1 decimal place" do
        user = Fabricate(:user)
        video = Fabricate(:video)
        review1 = Fabricate(:review, video: video, rating: 4,user: user)
        review2 = Fabricate(:review, video: video, rating: 3,user: user)
        expect(video.average_rating).to eq(3.5)
      end
    end

end

