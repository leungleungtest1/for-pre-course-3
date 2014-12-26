require 'spec_helper'

feature 'invite other people to join the website' do
  background do
    @bob = Fabricate(:user,name: "bob", email: "bobbob@email.com", password: "bob_pp")
  end

  scenario "user resets password",{js: true,vcr: true, driver: :selenium} do
    clear_emails
    visit sign_in_path
    page.fill_in "Email Address", :with => "bobbob@email.com"
    page.fill_in "Password", :with => "bob_pp"
    click_button "Sign in"
    #now home page
    expect(page).to have_content "You signed in successfully."
    click_link "Welcome bob!"
    click_link "Invite friends"
    #now invitation page
    expect(page).to have_content "Invite a friend to join MyFlix!"
    page.fill_in "Friend Name", :with => "Sa"
    page.fill_in "Friend's Email Address", :with => "sa@email.com"
    click_button "Send Invitation"
    visit sign_out_path
    open_email('sa@email.com')
    #now email of sa@email.com
    current_email.click_link "Myflix Website"
    expect(page).to have_content "Email Address"
    page.fill_in "user_password", with: "123456"
    page.fill_in "user_name", with: "Sa"
    page.fill_in "data-stripe-number", with: "4242424242424242"
    page.fill_in "data-stripe-cvc", with: "123"
    find('#data-stripe-exp-month').select("11")
    find('#data-stripe-exp-year').select("2016")    
    click_button "Sign Up"
    #now sign in page
    expect(page).to have_content "Sa register successfully"
    clear_emails
  end
end