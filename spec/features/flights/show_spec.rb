require 'rails_helper'

RSpec.describe 'Flight Show Page' do
  before :each do
    FlightPassenger.destroy_all
    Flight.destroy_all
    Passenger.destroy_all
    @flight1 = Flight.create(flight_number: '1727',
                            date: "08/03/20",
                            time: "08/03/20",
                            departure_city: "Denver",
                            arrival_city: "Reno")
    @flight2= Flight.create(flight_number: '1728',
                            date: "08/03/20",
                            time: "08/03/20",
                            departure_city: "Little Rock",
                            arrival_city: "Denver")
    @passenger1 = Passenger.create(name: 'Jenny', age: 26)
    @passenger2 = Passenger.create(name: 'Kyle', age: 33)
    @passenger3 = Passenger.create(name: 'Angel', age: 24)
    @passenger4 = Passenger.create(name: 'Brooks', age: 3)
    @flight_passenger1 = FlightPassenger.create(flight_id: @flight1.id, passenger_id: @passenger1.id)
    @flight_passenger2 = FlightPassenger.create(flight_id: @flight1.id, passenger_id: @passenger2.id)
    @flight_passenger3 = FlightPassenger.create(flight_id: @flight2.id, passenger_id: @passenger3.id)
    @flight_passenger4 = FlightPassenger.create(flight_id: @flight1.id, passenger_id: @passenger4.id)
  end

  describe 'As a visitor' do
    describe "When I visit a flight's show page" do
      it "Then I see the flight's number, date, time, departure city, and arrival city" do
        visit flight_path(@flight1)

        expect(current_path).to eq ("/flights/#{@flight1.id}")

          expect(page).to have_content(@flight1.flight_number)
          expect(page).to have_content(@flight1.date)
          expect(page).to have_content(@flight1.time)
          expect(page).to have_content(@flight1.departure_city)
          expect(page).to have_content(@flight1.arrival_city)

          expect(page).to_not have_content(@flight2.flight_number)
          expect(page).to_not have_content(@flight2.date)
          expect(page).to_not have_content(@flight2.time)
          expect(page).to_not have_content(@flight2.departure_city)
          expect(page).to_not have_content(@flight2.arrival_city)
      end
      it "And I see the names of all adult passengers on the flight" do
        visit flight_path(@flight1)
        within('.flight-passengers') do
          expect(page).to have_content(@passenger1.name)
          expect(page).to have_content(@passenger2.name)
          expect(page).to have_content(@passenger4.name)
          expect(page).to_not have_content(@passenger3.name)
        end
      end
      it "And I see the average age of all adult passengers on the flight" do
        visit flight_path(@flight1)
        within('.average_age') do
          expect(page).to have_content("Average Age of Adult Passengers: 28")
        end
      end
    end
  end
end