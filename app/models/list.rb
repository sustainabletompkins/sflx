class List < ActiveRecord::Base
  has_and_belongs_to_many :listings
  belongs_to :category
  belongs_to :user
  scope :pending, lambda { where('approved = FALSE') }
  scope :approved, lambda { where('approved = TRUE') }
end
