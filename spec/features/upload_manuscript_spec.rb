require 'spec_helper'

feature "an author uploads a manuscript" do
  let!(:user){Factory(:confirmed_user)}

  # variables
  title = "The Code Freakers"
  draft = 1
  genres = "fantasy, scifi"
  finish = "Add Manuscript"

  before do
    sign_in_as!(user)
    visit '/'
    click_link "Add New Manuscript"
    fill "manuscript_title", title
    fill "manuscript_draft", draft
    fill "manuscript_genres", genres
  end

  scenario "an author uploads their first draft in docx" do
    attach_file "upload", "spec/fixtures/features.docx"
    click_button finish
    content title
    content "Which Features are Most Important to You?"
  end

  scenario "an author uploads their first draft in txt" do
    attach_file "upload", "spec/fixtures/imaginary.txt"
    click_button finish
    content title
    content "Once upon a time"
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