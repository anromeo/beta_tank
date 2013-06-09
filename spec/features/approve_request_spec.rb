require "spec_helper"

feature "an author approves a requests" do
  let!(:user){Factory(:confirmed_user)}
  let!(:user2){Factory(:confirmed_user)}
  let!(:manuscript){Factory(:manuscript, :user => user2)}

  scenario "a reader requests to read an author's book" do
    sign_in_as!(user)
    visit "/"
    click_link "Browse Books to Beta Read"
    click_link "Abhorsen"
    content "Abhorsen"
    content "This is a story about magic"
    content user2.email
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
  end
end