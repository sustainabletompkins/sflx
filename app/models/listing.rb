class Listing < ActiveRecord::Base
  has_and_belongs_to_many :lists
  acts_as_taggable
  belongs_to :user
  belongs_to :place
  has_many :tag_suggestions
  scope :inactive, lambda { where('active = FALSE') }
  scope :approved, lambda { where('listings.active = TRUE') }
end
