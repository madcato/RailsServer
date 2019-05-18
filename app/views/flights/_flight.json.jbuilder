json.extract! flight, :id, :origin, :destination, :code, :created_at, :updated_at
json.url flight_url(flight, format: :json)
