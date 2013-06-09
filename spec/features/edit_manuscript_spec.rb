=begin
require 'spec_helper'

feature "an author edits their manuscript" do
  let!(:user){Factory(:confirmed_user)}
  let!(:manuscript){Factory(:manuscript, :user => user)}

  # variables
  title = "New Title"
  book = "This is some crazy new information"

  scenario "an author edits their manuscript" do
    sign_in_as!(:user)
    click_link manuscript.title
    click_link "Edit"
    fill "title", title
    fill "book", book
    click_button "Edit Manuscript"
    content
  end

end
=end