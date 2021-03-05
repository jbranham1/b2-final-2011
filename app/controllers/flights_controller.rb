class FlightsController < ApplicationController
  def index
    @flights = Flight.all.order_by_passenger_count_departure_city
  end

  def show
    @flight = Flight.find(params[:id])
  end
end
