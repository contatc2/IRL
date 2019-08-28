json.extract! @user, :id, :full_name, :email, :available
json.friends @user.friends do |friend|
  json.extract! friend, :id, :full_name
end
