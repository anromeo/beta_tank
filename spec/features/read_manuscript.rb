require 'spec_helper'

feature "an author, reader, or admin reads a manuscript" do
  let!(:user){Factory(:confirmed_user)}
  let!(:admin){Factory(:admin)}
  let!(:user2){Factory(:confirmed_user)}
  let!(:user3){Factory(:confirmed_user)}

  # variables
  title = "The Code Freakers"
  draft = 1
  finish = "Add Manuscript"
  read = "Which Features are Most Important to You?"

  before do
    sign_in_as!(user)
    visit '/'
    click_link "Add New Manuscript"
    fill "manuscript_title", title
    fill "manuscript_draft", draft
    attach_file "upload", "spec/fixtures/features.docx"
    click_button finish
  end

  scenario "an author reads their manuscript" do
    click_link 'Home'
    click_link title
    content read
  end
=begin
  scenario "an admin reads any user's manuscript" do
    click_link "Sign Out"
    sign_in_as!(admin)
    click_link "View Manuscripts"
    click_link title
    content read
  end

  scenario "an approved reader reads a manuscript" do
    click_link "Sign Out"
    sign_in_as!(user2)
    click_link "Browse Books to Beta Read"
    click_link title
    click_link "Send Beta Read Request"
    click_link "Sign Out"
    sign_in_as!(user)
    click_link "New Requests"
    click_link "Approve"
    click_link "Sign Out"
    sign_in_as!(user2)
    click_link title
    content title
    content read
  end

  scenario "an unapproved reader reads a manuscript" do
    click_link "Sign Out"
    sign_in_as!(user3)
    visit '/manuscripts/1'
    content "You do not have approval to read this manuscript"
  end
=end
end