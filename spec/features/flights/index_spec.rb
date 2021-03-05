require 'rails_helper'

RSpec.describe 'Flight Index Page' do
  before :each do
    FlightPassenger.destroy_all
    Flight.destroy_all
    Passenger.destroy_all
    @flight1 = Flight.create(flight_number: '1727',
                            date: DateTime.new(2021, 8, 23),
                            time: DateTime.new(2021, 8, 23,8),
                            departure_city: "Denver",
                            arrival_city: "Reno")
    @flight2= Flight.create(flight_number: '1728',
                            date: DateTime.new(2021, 8, 23),
                            time: DateTime.new(2021, 8, 23,10),
                            departure_city: "Little Rock",
                            arrival_city: "Denver")
    @flight3= Flight.create(flight_number: '1729',
                            date: DateTime.new(2021, 8, 23),
                            time: DateTime.new(2021, 8, 23,12),
                            departure_city: "Dallas",
                            arrival_city: "Miami")
    @passenger1 = Passenger.create(name: 'Jenny', age: 26)
    @passenger2 = Passenger.create(name: 'Kyle', age: 33)
    @passenger3 = Passenger.create(name: 'Angel', age: 24)
    @passenger4 = Passenger.create(name: 'Brooks', age: 3)
    @flight_passenger1 = FlightPassenger.create(flight_id: @flight1.id, passenger_id: @passenger1.id)
    @flight_passenger2 = FlightPassenger.create(flight_id: @flight1.id, passenger_id: @passenger2.id)
    @flight_passenger3 = FlightPassenger.create(flight_id: @flight2.id, passenger_id: @passenger3.id)
    @flight_passenger4 = FlightPassenger.create(flight_id: @flight1.id, passenger_id: @passenger4.id)
    @flight_passenger5 = FlightPassenger.create(flight_id: @flight3.id, passenger_id: @passenger3.id)
  end

  describe 'As a visitor' do
    describe 'When I visit the flights index page' do
      it "I see each flight in the system including its number, departure city, and arrival city" do
        visit flights_path

        expect(current_path).to eq ("/flights")

        within ".flight-#{@flight1.id}" do
          expect(page).to have_content(@flight1.flight_number)
          expect(page).to have_content(@flight1.departure_city)
          expect(page).to have_content(@flight1.arrival_city)
          expect(page).to_not have_content(@flight2.flight_number)
        end
        within ".flight-#{@flight2.id}" do
          expect(page).to have_content(@flight2.flight_number)
          expect(page).to have_content(@flight2.departure_city)
          expect(page).to have_content(@flight2.arrival_city)
          expect(page).to_not have_content(@flight1.flight_number)
        end
      end
      # it "And I see that flights are listed in alphabetical order by departure city (A - Z)" do
      #   visit flights_path
      #   expect(@flight2.flight_number).to appear_before (@flight1.flight_number)
      # end
      it "Then I see that flights are ordered by the number of passengers on the flight from most passengers to least and then alphabetical order by departure city (A - Z)" do
        visit flights_path
        expect(@flight1.flight_number).to appear_before (@flight2.flight_number)
        expect(@flight3.flight_number).to appear_before (@flight2.flight_number)
      end
      it "I see the passenger count for each flight" do
        visit flights_path

        expect(current_path).to eq ("/flights")

        within ".flight-#{@flight1.id}" do
          expect(page).to have_content("Passenger Count: #{@flight1.passenger_count}")
        end
      end
    end
  end
end
