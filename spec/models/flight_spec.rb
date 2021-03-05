require 'rails_helper'

RSpec.describe Flight, type: :model do
  before :each do
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
  end

  describe 'relationships' do
    it { should have_many :flight_passengers }
    it { should have_many(:passengers).through(:flight_passengers) }
  end

  describe 'validations' do
    it { should validate_presence_of :flight_number }
  end

  describe 'instance methods' do
    describe '::order_by_departure_city' do
      it "orders flights by departure city alphabetically (a-z)" do
        expect(Flight.order_by_departure_city.pluck(:departure_city)).to eq ([@flight2.departure_city, @flight1.departure_city])
      end
    end
  end
end
