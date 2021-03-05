require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'relationships' do
    it { should have_many :flight_passengers }
    it { should have_many(:passengers).through(:flight_passengers) }
  end

  describe 'validations' do
    it { should validate_presence_of :flight_number }
  end
end
