require 'spec_helper'
describe QueueItem do
  it {should belong_to(:user)}
  it {should belong_to(:video)}
  it "should have default position as its id" do
    queue_item = Fabricate(:queue_item)
    queue_item.save
    expect(queue_item.position).to eq(queue_item.id)
  end
  describe "#video_title" do
    it "return the title of associated video" do
      video = Fabricate(:video, title:"Monk")
      queue_item = Fabricate(:queue_item,video: video)
      expect(queue_item.video_title).to eq("Monk")
    end
  end

  describe '#rating' do
    it "returns the rating from the review when the review is present." do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 4)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(4)
    end
    it "returns nil when the reivew is not present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe '#category_name' do
    it "returns the name of from category when associated category is present" do
      user = Fabricate(:user)
      category = Fabricate(:category, name: "Shake Shake")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.category_name).to eq('Shake Shake')

    end
    it " returns nil when associated category is absent" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.category_name).to eq(nil)
    end
  end

  describe "#category" do
    it "returns the category of the associated video" do
      user = Fabricate(:user)
      category = Fabricate(:category, name: "Shake Shake")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.category).to eq(category)
    end

  end
end