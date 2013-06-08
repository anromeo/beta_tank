require 'spec_helper'

feature "a user logs in" do
  let!(:user){Factory(:confirmed_user)}

  scenario "a user logs into the site" do
    visit '/'
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    page.should have_content "Signed in as #{user.email}"

  end
end