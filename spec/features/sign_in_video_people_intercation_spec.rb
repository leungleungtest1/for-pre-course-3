require 'spec_helper'

feature 'people follow' do
  background do 
    @alice = Fabricate(:user)
    @bob = Fabricate(:user)
    @tv = Fabricate(:category)
    @monk = Fabricate(:video, category: @tv)
    review1 = Fabricate(:review, user: @bob,video: @monk)
  end
  scenario "with valid user to follow and unfollow" do
    visit sign_in_path
    fill_in('Email Address', with: @alice.email)
    fill_in('Password',with: @alice.password)
    click_button "Sign in"
    expect(page).to have_content "You signed in successfully."
    #now you are on front page
    find(:xpath, "//a[@href='videos/#{@monk.id}']").click
    expect(page).to have_content "#{@bob.name}"
    #now on video page of monk
    find(:xpath, "//a[@href='/users/#{@bob.id}']").click
    expect(page).to have_content "#{@bob.name}"
    #now on bob profile page
    click_link("Follow")
    expect(page).to have_content "#{@bob.name}"
    #now on alice people page
    find(:xpath, "//a[@href='/peoples/#{@bob.id}']").click
    expect(page).to have_content "unfollow #{@bob.name}"
  end
end