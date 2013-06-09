require 'spec_helper'

feature "a user signs up" do

  scenario "a user signs up for the site" do
    visit "/"
    click_link "Join the Beta Tank"
    fill "Email", "author@example.com"
    fill "Password", "password"
    fill "Password confirmation", "password"
    click_button "Join"
    open_email "author@example.com", with_subject: /Confirmation/
    click_first_link_in_email
    content "Your account was successfully confirmed"

  end

end