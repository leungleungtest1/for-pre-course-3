require 'spec_helper'

feature 'user register and pay', {js: true, vcr: true} do
  background do
    ENV['STRIPE_SECRET_KEY']= "sk_test_g9KW02Qtqasrw6Iu9Vj59gMm"
    ENV['STRIPE_PUBLIC_KEY']= "pk_test_tRkCxDbnhy8B0oUjBNcTT7l4"
  end

  scenario " with valid user info and valid card" do
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
  scenario " with valid user info and invalid card" do
    visit register_path
    page.fill_in "user_email", with: "user4@email.com"
    page.fill_in "user_password", with: "123456"
    page.fill_in "user_name", with: "user4" 
    page.fill_in "data-stripe-number", with: "4545641231545542"
    page.fill_in "data-stripe-cvc", with: "123"
    find('#data-stripe-exp-month').select("11")
    find('#data-stripe-exp-year').select("2016")
    click_button "Sign Up"
    
    expect(page).to have_content " Your card number is incorrect"
  end
  scenario " with valid user info and declined card" do
    visit register_path
    page.fill_in "user_email", with: "user4@email.com"
    page.fill_in "user_password", with: "123456"
    page.fill_in "user_name", with: "user4" 
    page.fill_in "data-stripe-number", with: "4000000000000002"
    page.fill_in "data-stripe-cvc", with: "123"
    find('#data-stripe-exp-month').select("11")
    find('#data-stripe-exp-year').select("2016")
    click_button "Sign Up"
    
    expect(page).to have_content "You failed to register"
    expect(page).to have_content "Your card was declined"
  end
  scenario " with invalid user info and valid card"  do
    visit register_path
    page.fill_in "user_email", with: "com"
    page.fill_in "user_password", with: "123456"
    page.fill_in "user_name", with: "user4" 
    page.fill_in "data-stripe-number", with: "4242424242424242"
    page.fill_in "data-stripe-cvc", with: "123"
    find('#data-stripe-exp-month').select("11")
    find('#data-stripe-exp-year').select("2016")
    click_button "Sign Up"
    
    expect(page).to have_content "Email is invalid"
    expect(page).to have_content "You are not charged"
  end
  scenario " with invalid user info and invalid card" do
    visit register_path
    page.fill_in "user_email", with: "com"
    page.fill_in "user_password", with: "123456"
    page.fill_in "user_name", with: "user4" 
    page.fill_in "data-stripe-number", with: "4122312312314242"
    page.fill_in "data-stripe-cvc", with: "123"
    find('#data-stripe-exp-month').select("11")
    find('#data-stripe-exp-year').select("2016")
    click_button "Sign Up"
    
    expect(page).to have_content "Email is invalid"
    expect(page).to have_content "You are not charged"
  end
  scenario " with valid user info and declined card" do
    visit register_path
    page.fill_in "user_email", with: "com"
    page.fill_in "user_password", with: "123456"
    page.fill_in "user_name", with: "user4" 
    page.fill_in "data-stripe-number", with: "4000000000000002"
    page.fill_in "data-stripe-cvc", with: "123"
    find('#data-stripe-exp-month').select("11")
    find('#data-stripe-exp-year').select("2016")
    click_button "Sign Up"
    
    expect(page).to have_content "Email is invalid"
    expect(page).to have_content "You are not charged"
  end
  
end

