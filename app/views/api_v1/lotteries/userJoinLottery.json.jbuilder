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
  json.head_shot @user.head_shot.url
end