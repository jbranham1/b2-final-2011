class Flight < ApplicationRecord
  has_many :flight_passengers
  has_many :passengers, through: :flight_passengers

  validates_presence_of :flight_number

  def self.order_by_departure_city
    order(departure_city: :desc)
  end

  def average_age_of_adult_passengers
    passengers.where('age >= 18').average(:age)
  end
end
