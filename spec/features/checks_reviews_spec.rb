=begin
require 'spec_helper'

feature "an author or admin can read reviews" do
  let!(:user){Factory(:confirmed_user)}
  let!(:admin){Factory(:admin)}
  let!(:manuscript){Factory(:manuscript, :user => user)}
  let!(:review){Factory(:review, :manuscript => manuscript)}

  scenario "an author reads their reviews" do
    sign_in_as!(user)
    click_link manuscript.title
    click_link "Read Reviews"
    content review
  end

  scenario "an admin reads a users reviews" do
    sign_in_as!(admin)
    click_link "View Manuscripts"
    click_link "Read Reviews"
    content review
  end
end
=end