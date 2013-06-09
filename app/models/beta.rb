class Beta < ActiveRecord::Base
  attr_accessible :manuscript_id, :user_id, :approval

  belongs_to :user
  belongs_to :manuscript
end
