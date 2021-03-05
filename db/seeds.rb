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
@passenger1 = Passenger.create(name: 'Jenny', age: 26)
@passenger2 = Passenger.create(name: 'Kyle', age: 33)
@passenger3 = Passenger.create(name: 'Angel', age: 24)
@passenger4 = Passenger.create(name: 'Brooks', age: 3)
@flight_passenger1 = FlightPassenger.create(flight_id: @flight1.id, passenger_id: @passenger1.id)
@flight_passenger2 = FlightPassenger.create(flight_id: @flight1.id, passenger_id: @passenger2.id)
@flight_passenger3 = FlightPassenger.create(flight_id: @flight2.id, passenger_id: @passenger3.id)
@flight_passenger4 = FlightPassenger.create(flight_id: @flight1.id, passenger_id: @passenger4.id)
