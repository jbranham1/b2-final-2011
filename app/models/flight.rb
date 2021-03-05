class Flight < ApplicationRecord
  has_many :flight_passengers
  has_many :passengers, through: :flight_passengers

  validates_presence_of :flight_number

  # def self.order_by_departure_city
  #   order(departure_city: :desc)
  # end

  def average_age_of_adult_passengers
    passengers.where('age >= 18').average(:age)
  end

  def passenger_count
    passengers.count
  end

  def self.order_by_passenger_count_departure_city
    joins(:passengers)
    .select('flights.*, count(passengers.id) as passenger_count')
    .group(:id)
    .order(passenger_count: :desc, departure_city: :asc)
  end
end
