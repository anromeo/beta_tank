# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
BetaTank::Application.initialize!

Time::DATE_FORMATS[:posted_time] = "Posted at %b %d, %Y"

Time::DATE_FORMATS[:updated_time] = "Last Updated at %b %d, %Y"