=begin
require 'spec_helper'

feature "an author or admin deletes a manuscript" do
  let!(:user){Factory(:confirmed_user)}
  let!(:admin){Factory(:admin)}
  let!(:manuscript){Factory(:manuscript, :user => user)}

  # variables
  title = "New Title"
  book = "This is some crazy new information"

  scenario "an author deletes their manuscript" do
    sign_in_as!(:user)
    click_link manuscript.title
    click_link "Destroy"
    content "You have deleted " + title
    page.should not_have.content(title)
  end

  scenario "an admin deletes an author's manuscript" do
    sign_in_as!(:admin)
    click_link "View Manuscripts"
    click_link title
    click_link "Destroy"
    content "You have deleted " + title
    visit '/'
    click_link "View Manuscripts"
    page.should not_have.content(title)
  end
end
=end