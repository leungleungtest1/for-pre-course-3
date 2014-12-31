require 'spec_helper'

feature "Admin Sees Payments" do
  background do
    alice = Fabricate(:user, name: "alice", email: "alice@email.com")
    Fabricate(:payment, amount: 999, user: alice)
  end
  scenario "admin can see payments" do
    sign_in(Fabricate(:admin))
    visit admin_userpaymentrecord_path
    expect(page).to have_content("9.99")
    expect(page).to have_content("alice")
    expect(page).to have_content("alice@email.com")
  end
  scenario "admin cannot see payments" do
    sign_in(Fabricate(:user))
    visit admin_userpaymentrecord_path
    expect(page).not_to have_content("9.99")
    expect(page).not_to have_content("alice")
    expect(page).not_to have_content("alice@email.com")
  end

end