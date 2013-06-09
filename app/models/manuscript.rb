class Manuscript < ActiveRecord::Base
  attr_accessible :draft, :genres, :title, :lines, :user_id, :description

  has_many :contents, dependent: :destroy
  has_many :betas, dependent: :destroy
  belongs_to :user
end
