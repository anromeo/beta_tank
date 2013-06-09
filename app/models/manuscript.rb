class Manuscript < ActiveRecord::Base
  attr_accessible :draft, :genres, :title, :lines

  has_many :contents
end
