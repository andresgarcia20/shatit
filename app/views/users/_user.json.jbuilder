json.extract! user, :id, :name, :surname, :nickname, :phoneNumber, :birthday, :email, :created_at, :updated_at
json.url user_url(user, format: :json)
