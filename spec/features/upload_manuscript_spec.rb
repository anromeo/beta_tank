require 'spec_helper'

feature "an author uploads a manuscript" do
  let!(:user){Factory(:confirmed_user)}

  # variables
  title = "The Code Freakers"
  draft = 1
  genres = "fantasy, scifi"
  book = "tons and tons and tons of text"
  finish = "Add Manuscript"
  bookFile = "spec/fixtures/features.docx"

  before do
    sign_in_as!(user)
    visit '/'
    click_link "Add New Manuscript"
    fill "manuscript_title", title
    fill "manuscript_draft", draft
    fill "manuscript_genres", genres
  end

  scenario "an author uploads their first draft" do
    attach_file "upload", bookFile
    click_button finish
    content title
    content "Which Features are Most Important to You?"
  end

  scenario "an author pastes their first draft" do
    fill "book", "Hopeful information"
    click_button finish
    content title
    content "Hopeful information"
  end

  scenario "an author doesn't upload or paste draft" do
    click_button finish
    content "Please, submit a file or copy" +
            " and paste your manuscript in the box"
  end
end