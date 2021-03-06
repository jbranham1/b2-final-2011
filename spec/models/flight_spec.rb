require 'rails_helper'

RSpec.describe Flight, type: :model do
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
                            arrival_city: "Dallas")
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

  describe 'relationships' do
    it { should have_many :flight_passengers }
    it { should have_many(:passengers).through(:flight_passengers) }
  end

  describe 'validations' do
    it { should validate_presence_of :flight_number }
  end

  describe 'class methods' do
    # describe '::order_by_departure_city' do
    #   it "orders flights by departure city alphabetically (a-z)" do
    #     expect(Flight.order_by_departure_city.pluck(:departure_city)).to eq([@flight2.departure_city, @flight1.departure_city])
    #   end
    # end
    describe '::order_by_passenger_count_departure_city' do
      it "orders flights by passenger count largest to smallest, then departure city (a-z)" do
        expect(Flight.order_by_passenger_count_departure_city).to eq([@flight1, @flight3, @flight2])
      end
    end
  end
  describe 'instance methods' do
    describe '#adult_passengers' do
      it "gets the passengers for the flight over the age of 17" do
        expect(@flight1.adult_passengers).to eq([@passenger1, @passenger2])
      end
    end
    describe '#average_age_of_adult_passengers' do
      it "gets the average age of all adult passengers on the flight" do
        expect(@flight1.average_age_of_adult_passengers).to eq(29.5)
      end
    end
    describe '#passenger_count' do
      it "gets the amount of passengers" do
        expect(@flight1.passenger_count).to eq(3)
      end
    end
  end

end
