module FillinHelpers
  def content(content)
    page.should have_content(content)
  end
  def fill(inputName, input)
    fill_in inputName, with: input
  end
  def click_id(id)
    find(id).click
  end
end

RSpec.configure do |c|
  c.include FillinHelpers
end