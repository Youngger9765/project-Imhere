json.user do
  json.msg "user 編輯成功"
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

  json.fb_lock @fb_lock
  json.fb_name @user.fb_name
  json.fb_email @user.fb_email
  json.fb_head_shot @user.fb_head_shot
end