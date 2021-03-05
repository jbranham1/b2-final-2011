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
      it "And I see that flights are listed in alphabetical order by departure city (A - Z)" do
        visit flights_path
        expect(@flight2.flight_number).to appear_before (@flight1.flight_number)
      end
    end
  end
end
