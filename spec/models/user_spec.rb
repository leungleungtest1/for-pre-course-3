require "spec_helper"

describe User do
  it { should have_many(:queue_items).order('position asc')}
  it { should have_many(:reviews).order('created_at desc')}
  it { should allow_value("hasdf@yahoo.com","&(**(&@nae.net").for(:email)}
  it { should_not allow_value("I am not email address","@@@notemail.com").for(:email)}
  it_behaves_like "generate_token" do 
    let(:model){:user}
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
  describe "#failed_to_pay?" do
    let(:alice){Fabricate(:user)}
    let(:fail_payment){Fabricate(:payment, status: "failed")}
    let(:payment){Fabricate(:payment)}
    it "returns true when a user failed to pay" do
      alice.payments << fail_payment
      expect(alice.failed_to_pay?).to be_truthy
    end
    it "returns false when a user paied successfully" do
      alice.payments << payment
      expect(alice.failed_to_pay?).to eq(false)
    end
    it "returns false when a user does not have payment record" do
      expect(alice.failed_to_pay?).to eq(false)
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