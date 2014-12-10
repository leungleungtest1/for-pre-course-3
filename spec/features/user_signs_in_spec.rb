require 'spec_helper'

feature 'User signs in' do
  background do
    @alice = Fabricate(:user)
  end
  scenario "with existing email address and password" do
    visit sign_in_path
    fill_in('Email Address', with: @alice.email)
    fill_in('Password', :with => @alice.password)
    click_button "Sign in"
    page.should have_content "You signed in successfully."
  end
end