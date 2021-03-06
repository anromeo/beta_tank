module AuthenticationHelpers
  def sign_in_as!(user)
    visit '/'
    fill_in "Email", :with => user.email
    fill_in "Password", :with => "password"
    click_button 'Sign in'
    page.should have_content("Signed in")
	end
end

RSpec.configure do |c|
  c.include AuthenticationHelpers
end