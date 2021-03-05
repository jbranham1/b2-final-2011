class Flight < ApplicationRecord
  has_many :flight_passengers
  has_many :passengers, through: :flight_passengers

  validates_presence_of :flight_number

  def self.order_by_departure_city
    order(departure_city: :desc)
  end
end
