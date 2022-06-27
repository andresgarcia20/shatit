json.extract! trip, :id, :user_id, :origin, :destinations, :available_seats, :departure_date, :created_at, :updated_at
json.url trip_url(trip, format: :json)
