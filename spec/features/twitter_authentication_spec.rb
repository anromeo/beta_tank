require 'spec_helper'

feature "Twitter Auth" do
  before do
    OmniAuth.config.mock_auth[:twitter] = {
      "extra" => {
        "raw_info" => {
          "id" => '12345',
          "screen_name" => "twit",
          "display_name" => "A Twit"
        }
      }
    }
  end

  it "signing in w/ Twitter" do
    visit '/'
    click_id "#twitter_auth"
    content "Signed in with Twitter successfully."
  end
end