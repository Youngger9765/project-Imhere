json.lottery do
  json.msg "user join lottery success"
  json.lottery_id @lottery.id
  json.lottery_name @lottery.name
  json.user_id @user.id
  json.user_name @user.name
  json.email @user.email
  json.phone_number @user.phone_number
  json.address @user.address
  json.birthday @user.birthday

  if @user.head_shot.url == "/images/original/missing.png"
    json.head_shot nil
  else
    json.head_shot @user.head_shot.url
  end

end