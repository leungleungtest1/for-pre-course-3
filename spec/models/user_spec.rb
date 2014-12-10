require "spec_helper"

describe User do
  it { should have_many(:queue_items).order('position asc')}

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
end