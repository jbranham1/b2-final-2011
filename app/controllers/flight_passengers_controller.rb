class FlightPassengersController < ApplicationController
  def destroy
    flight = Flight.find(params[:flight_id])
    FlightPassenger.where(flight_id: params[:flight_id], passenger_id: params[:id]).destroy_all
    redirect_to flight_path(flight)
  end
end
