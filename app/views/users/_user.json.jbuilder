json.extract! user, :id, :name, :surname, :nickname, :phone_number, :age, :email, :created_at, :updated_at
json.url user_url(user, format: :json)
