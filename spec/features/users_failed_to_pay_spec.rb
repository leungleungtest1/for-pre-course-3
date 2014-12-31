=begin
require "spec_helper"

feature "User with a card failed to pay",{js: true, vcr:true, driver: :selenium} do

  scenario "User register successfully but failed to pay" do
    visit register_path
    page.fill_in "user_email", with: "user102@email.com"
    page.fill_in "user_password", with: "123456"
    page.fill_in "user_name", with: "user102" 
    page.fill_in "data-stripe-number", with: "4000000000000341"
    page.fill_in "data-stripe-cvc", with: "123"
    find('#data-stripe-exp-month').select("11")
    find('#data-stripe-exp-year').select("2016")
    click_button "Sign Up"
    
    expect(page).to have_content "user102 register successfully"
    expect(page).to have_content "You paid 9 dollars and 99 cents"
    
    sign_in user102
    expect(page).to have_content "welcome user102"
  end
end
=end