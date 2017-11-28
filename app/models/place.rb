class Place < ActiveRecord::Base
  has_many :listings
  belongs_to :county
end
