class Category < ActiveRecord::Base
  has_many :lists
  has_many :listings, -> { uniq }, through: :lists
end