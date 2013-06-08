require 'spec_helper'

feature "a user signs up" do

  scenario "a user signs up for the site" do
    visit "/"
    click_link "Join the Beta Tank"
    fill_in "Email", :with => "author@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Join"
    open_email "author@example.com", with_subject: /Confirmation/
    click_first_link_in_email
    page.should have_content("Your account was successfully confirmed")

  end

end