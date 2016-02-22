json.activity_data do
  json.id @activity.id
  json.name @activity.name
  json.status @activity.status
  
  if @activity.banner.url == "/images/original/missing.png"
    json.banner_url nil
  else
    json.banner_url @activity.banner.url
  end

  if @activity.logo.url == "/images/original/missing.png"
    json.logo_url nil
  else
    json.logo_url @activity.logo.url
  end
end

json.activity_milestones @milestones

json.activity_content do
  json.content @activity.content
end

json.activity_info do
  json.information @activity.information

  if @activity.information_picture.url == "/images/original/missing.png"
    json.information_pic nil
  else
    json.information_pic @activity.information_picture.url
  end

  json.start_time @activity.start_time
  json.end_time @activity.end_time
  json.location @activity.location
  json.latitude @activity.latitude
  json.longitude @activity.longitude
end

json.activity_merchants @merchants.each do |merchant|
  json.id merchant.id
  json.name merchant.name
  json.description merchant.description
end

json.activity_lotteries @lotteries.each do |lottery|
  json.id lottery.id

  if lottery.logo.url == "/images/original/missing.png"
    json.logo_url nil
  else
    json.logo_url lottery.logo.url
  end

  json.name lottery.name
  json.content lottery.content
  json.start_time lottery.start_time
  json.end_time lottery.end_time
  json.lottery_users lottery.users_count
end
