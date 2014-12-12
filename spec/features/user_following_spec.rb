require 'spec_helper'

feature 'User following' do
  scenario "user follows and unfollows someone" do
    alice = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video)
    review = Fabricate(:review, user: alice, video: video)
  
  end
end

def unfollow(user)
  find(:xpath, "//a[@href='/peoples/#{user.id}']").click
end