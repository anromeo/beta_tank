class Content < ActiveRecord::Base
  attr_accessible :line, :manuscript_id

  belongs_to :manuscript
end
