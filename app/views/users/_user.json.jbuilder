json.extract! user, :id, :name, :password_hash, :favourite_color, :created_at, :updated_at
json.url user_url(user, format: :json)
