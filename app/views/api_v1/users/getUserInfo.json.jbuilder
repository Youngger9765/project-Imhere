json.user do
  json.id @user.id
  json.name @user.name
  json.email @user.email
  json.phone_number @user.phone_number
  json.address @user.address
  json.latitude @user.latitude
  json.longitude @user.longitude
  json.head_shot @user_head_shot_url
  json.birthday @user.birthday
end