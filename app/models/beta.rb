class Beta < ActiveRecord::Base
  attr_accessible :bio, :email, :first_name, :last_name, :username

  belongs_to :user
end
