require 'spec_helper'

feature 'reset_passwords' do
  background do
  @bob = Fabricate(:user, email: "bobbob@email.com")
  end

  scenario "user resets password" do
    clear_emails
    visit sign_in_path

    find(:xpath,"//a[@href='/forgot_password']").click
    page.should have_content("We will send you email with a link that you can use to reset ")
    #now on the forgot_password page
    page.fill_in 'Email Address', :with => 'bobbob@email.com'
    click_button " Send Email "
    page.should have_content("We have send a email with instruction to reset your password")
    open_email('bobbob@email.com')
    current_email.click_link "Reset password"
    expect(page).to have_content 'New Password'
    #now on password_resets page
    page.fill_in "New Password", :with => 'new_pp'
    click_button "Reset password"
    #now on sign in page
    expect(page).to have_content "You resetted password successfully. Please Sign in"
    page.fill_in "Email Address", :with => "bobbob@email.com"
    page.fill_in "Password", :with => "new_pp"
    click_button "Sign in"
    expect(page).to have_content "You signed in successfully."
    #now on home page
  end
end