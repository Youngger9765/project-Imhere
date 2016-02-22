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
  
  if @user.head_shot.url == "/images/original/missing.png"
    json.head_shot nil
  else
    json.head_shot @user.head_shot.url
  end
end