class Category < ActiveRecord::Base
  has_many :lists
  has_many :listings, -> { distinct }, through: :lists, class_name: 'Listing'
end
