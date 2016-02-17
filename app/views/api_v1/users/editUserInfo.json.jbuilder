json.user do
  json.msg "user update success"
  json.id @user.id
  json.name @user.name
  json.email @user.email
  json.phone_number @user.phone_number
  json.address @user.address
  json.latitude @user.latitude
  json.longitude @user.longitude
  json.birthday @user.birthday
  json.head_shot @user.head_shot.url
end