require 'spec_helper'

feature "an author, reader, or admin reads a manuscript" do
  let!(:user){Factory(:confirmed_user)}

  # variables
  title = "The Code Freakers"
  draft = 1
  finish = "Add Manuscript"

  scenario "an author reads their manuscript" do
    sign_in_as!(user)
    visit '/'
    click_link "Add New Manuscript"
    fill "manuscript_title", title
    fill "manuscript_draft", draft
    attach_file "upload", "spec/fixtures/features.docx"
    click_button finish
    click_link 'Home'
    click_link title
    content "Which Features are Most Important to You?"
  end

  scenario "an admin reads any user's manuscript" do
  end

  scenario "an approved reader reads a manuscript" do
  end

  scenario "an unapproved reader reads a manuscript" do
  end

end