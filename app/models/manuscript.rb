class Manuscript < ActiveRecord::Base
  attr_accessible :draft, :genres, :title, :lines, :user_id

  has_many :contents, dependent: :destroy
  belongs_to :user
end
