=begin
require 'spec_helper'

feature "a reader reviews a manuscript" do
  let!(:user){Factory(:confirmed_user)}
  let!(:user2){Factory(:confirmed_user)}
  let!(:manuscript){Factory(:manuscript, :user => user2)}

  before do
    sign_in_as!(user)
    visit "/"
    click_link "Browse Books to Beta Read"
    click_link "Abhorsen"
    content "Abhorsen"
    content "This is a story about magic"
    content manuscript.description
    click_link "Send Beta Read Request"
    content "A beta read request has been sent to " + user2.email
    click_link "Sign Out"
    visit "/"
    sign_in_as!(user2)
    click_link "New Requests"
    content "Abhorsen"
    content user2.email
    click_link "Approve"
    content "You have approved " + user.email + "to read your manuscript"
    click_link "Sign Out"
  end


  scenario "a reader reviews a manuscript" do
    sign_in_as!(user)
    visit "/"
    click_link "Abhorsen"
    content "Abhorsen"
    content user2.email
    content manuscript.description
    click_link "This vivid description is amazing"
    fill "review", "Here's my comment"
    click_button "Submit"
    content "Your comment has been sent"
  end
end
=end