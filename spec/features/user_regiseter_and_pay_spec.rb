require 'spec_helper'

feature 'user register and pay' do
  background do
    ENV['STRIPE_SECRET_KEY']= "sk_test_g9KW02Qtqasrw6Iu9Vj59gMm"
    ENV['STRIPE_PUBLIC_KEY']= "pk_test_tRkCxDbnhy8B0oUjBNcTT7l4"
  end

  scenario " a new user register with card payment", {js: true, vcr: true} do
    visit register_path
    page.fill_in "user_email", with: "user4@email.com"
    page.fill_in "user_password", with: "123456"
    page.fill_in "user_name", with: "user4"
    page.fill_in "data-stripe-number", with: "4242424242424242"
    page.fill_in "data-stripe-cvc", with: "123"
    find('#data-stripe-exp-month').select("11")
    find('#data-stripe-exp-year').select("2016")
    click_button "Sign Up"
    
    expect(page).to have_content "user4 register successfully"
    expect(page).to have_content "You paid 9 dollars and 99 cents"
  end
end