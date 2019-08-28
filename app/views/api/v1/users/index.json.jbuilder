json.array! @users do |user|
  json.extract! user, :id, :full_name, :email, :available
end
