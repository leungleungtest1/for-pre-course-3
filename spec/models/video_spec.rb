require 'spec_helper'

describe Video do 
    it { should belong_to(:category)}
    it { should validate_presence_of(:title)}
    it { should validate_presence_of(:description)}
    describe "search_by_title" do
      it " returns an array of requied videos ordered by created_at if the videos of the title are present" do 
      dinosaur1 = Video.create(title:"dinosaur", description: "Tasty dinosaur1", created_at: 1.day.ago)
      dinosaur2 = Video.create(title:"dinosaur", description: "Tasty dinosaur2", created_at: 2.day.ago)
      dinosaur3 = Video.create(title:"dinosaur", description: "Tasty dinosaur3" , created_at: 3.day.ago)
      assassin = Video.create(title: 'assassin', description: 'Assassin is a way to strive.' , created_at: 4.day.ago)

      expect(Video.search_by_title("dinosaur")).to eq([dinosaur3,dinosaur2,dinosaur1])
      end
      it " returns an array of one videos if only one video of the title is present" do 
      dinosaur1 = Video.create(title:"dinosaur", description: "Tasty dinosaur1")
      dinosaur2 = Video.create(title:"dinosaur", description: "Tasty dinosaur2")
      dinosaur3 = Video.create(title:"dinosaur", description: "Tasty dinosaur3")
      assassin = Video.create(title: 'assassin', description: 'Assassin is a way to strive.')

      expect(Video.search_by_title("assassin")).to eq([assassin])
      end
      it " returns an array of one videos if only one video matched partially" do 
      dinosaur1 = Video.create(title:"dinosaur", description: "Tasty dinosaur1")
      dinosaur2 = Video.create(title:"dinosaur", description: "Tasty dinosaur2")
      dinosaur3 = Video.create(title:"dinosaur", description: "Tasty dinosaur3")
      assassin = Video.create(title: 'assassin training', description: 'Assassin is a way to strive.')

      expect(Video.search_by_title("assassin")).to eq([assassin])
      end
      it "returns an empty array if the videos of the title are absent"do 
      dinosaur1 = Video.create(title:"dinosaur", description: "Tasty dinosaur1")
      dinosaur2 = Video.create(title:"dinosaur", description: "Tasty dinosaur2")
      dinosaur3 = Video.create(title:"dinosaur", description: "Tasty dinosaur3")
      assassin = Video.create(title: 'assassin', description: 'Assassin is a way to strive.')

      expect(Video.search_by_title("no_title")).to eq([])
      end
      it "returns an empty array for a search with an empty string" do 
      dinosaur1 = Video.create(title:"dinosaur", description: "Tasty dinosaur1")
      dinosaur2 = Video.create(title:"dinosaur", description: "Tasty dinosaur2")
      dinosaur3 = Video.create(title:"dinosaur", description: "Tasty dinosaur3")
      assassin = Video.create(title: 'assassin', description: 'Assassin is a way to strive.')

      expect(Video.search_by_title("")).to eq([])
      end
    end


end

