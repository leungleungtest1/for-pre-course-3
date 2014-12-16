require "spec_helper"

describe User do
  it { should have_many(:queue_items).order('position asc')}
  it { should have_many(:reviews).order('created_at desc')}
  it "generate a radom token when the user is created" do
    bob = Fabricate(:user)
    expect(bob.token).not_to be_nil
  end
  describe "#have_queued_video?" do
    let(:user){Fabricate(:user)}
    let(:video){Fabricate(:video)}
    it "returns false when user queue the video" do
      queue_item = QueueItem.create(user_id: user.id, video_id: video.id, position: 1)
      expect(user.have_queued_video?(video)).to eq(false)
    end
    it "returns true wehn user do not queue the vidoe" do
      expect(user.have_queued_video?(video)).to eq(true)
    end
  end

  describe "#follow?" do
    let(:alice){Fabricate(:user)}
    let(:bob){Fabricate(:user)}
    it "returns true when user follow the leader" do
      relationship = Fabricate(:relationship, leader_id: bob.id, follower_id: alice.id)
      expect(alice.follow?(bob)).to eq(true)
    end
    it "returns false when user does not follow the leader" do
      expect(alice.follow?(bob)).to eq(false)
    end
  end
end