class Route < ActiveRecord::Base
  validates :route_number, uniqueness: true

  has_and_belongs_to_many :stops
end
