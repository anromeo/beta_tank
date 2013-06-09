require 'spec_helper'

feature "a user logs in" do
  let!(:user){Factory(:confirmed_user)}

  scenario "a user logs into the site" do
    visit '/'
    fill "Email", user.email
    fill "Password", user.password
    click_button "Sign in"
    content "Signed in as #{user.email}"

  end
end