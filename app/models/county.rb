class County < ActiveRecord::Base
  has_many :places
  has_many :listings, -> { distinct }, through: :places, class_name: 'Listing'
end
