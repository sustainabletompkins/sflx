class List < ActiveRecord::Base
  has_and_belongs_to_many :listings
  belongs_to :category
  belongs_to :user
  scope :inactive, lambda { where('active = FALSE') }
  scope :active, lambda { where('active = TRUE') }
end
