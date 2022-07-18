json.extract! trip_join_request, :id, :companions, :pets, :luggage, :kids, :stage, :created_at, :updated_at
json.url trip_join_request_url(trip_join_request, format: :json)
