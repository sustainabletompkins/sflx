class Listing < ActiveRecord::Base
  has_and_belongs_to_many :lists
  acts_as_taggable
  belongs_to :user

  scope :inactive, lambda { where('active = FALSE') }
end
