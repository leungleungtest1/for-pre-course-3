require 'spec_helper'

feature 'my queue page' do
  background do
    @alice = Fabricate(:user)
    @cat1 = Fabricate(:category)
    @video1 = Fabricate(:video, category: @cat1)
    @video2 = Fabricate(:video, category: @cat1)
    @categories = Category.all
  end
  scenario "add video to my queue" do
    visit sign_in_path
    fill_in('Email Address', with: @alice.email)
    fill_in('Password', :with => @alice.password)
    click_button "Sign in"
    visit videos_path
    find("a[href='videos/#{@video1.id}']").click
    page.should have_content "#{@video1.title}"
  end

  scenario "add video to my queue from video page" do
    visit sign_in_path
    fill_in('Email Address', with: @alice.email)
    fill_in('Password', :with => @alice.password)
    click_button "Sign in"
    visit video_path(@video1)
    click_link "+Queue"
    page.should have_content "#{@video1.title}"
  end

  scenario "visit the video from my queue page" do
    visit sign_in_path
    fill_in('Email Address', with: @alice.email)
    fill_in('Password', :with => @alice.password)
    click_button "Sign in"
    visit video_path(@video1)
    click_link "+Queue"
    #now, you are in my queue page
    click_link "#{@video1.title}"
    page.should have_content "#{@video1.description}"
  end
    scenario "visit the video from my queue page and the +queue button is invisible" do
    visit sign_in_path
    fill_in('Email Address', with: @alice.email)
    fill_in('Password', :with => @alice.password)
    click_button "Sign in"
    visit video_path(@video1)
    click_link "+Queue"
    #now, you are in my queue page
    click_link "#{@video1.title}"
    has_no_link?("+Queue")
  end

  scenario "visit the videos page and add video to my queue" do
    visit sign_in_path
    fill_in('Email Address', with: @alice.email)
    fill_in('Password', :with => @alice.password)
    click_button "Sign in"
    visit video_path(@video1)
    click_link "+Queue"
    #now, you are in my queue page
    visit video_path(@video2)
    click_link "+Queue"


    find("input[data-video-id='#{@video1.id}']").set('10')
    click_button "Update Instant Queue" 
    expect(find("input[data-video-id='#{@video1.id}']").value).to eq("2")
  end
end