json.time_now Time.now
json.normal_notifications @normal_notifications do |notification|
  json.id notification.id
  json.title notification.title
  json.content notification.content
  json.start_time notification.start_time
  json.countdown_end_time notification.countdown_end_time

  json.url notification.url

  if notification.logo.url == "/images/original/missing.png"
    json.logo_url nil
  else
    json.logo_url notification.logo.url
  end

  if notification.image.url == "/images/original/missing.png"
    json.image_url nil
  else
    json.image_url notification.image.url
  end

  json.is_user_clicked notification.user_clicked_list.include?(@user.id.to_s)
end

json.limited_notifications @limited_notifications do |notification|
  json.id notification.id
  json.title notification.title
  json.content notification.content
  json.start_time notification.start_time
  json.countdown_end_time notification.countdown_end_time

  json.url notification.url

  if notification.logo.url == "/images/original/missing.png"
    json.logo_url nil
  else
    json.logo_url notification.logo.url
  end

  if notification.image.url == "/images/original/missing.png"
    json.image_url nil
  else
    json.image_url notification.image.url
  end

  json.is_user_clicked notification.user_clicked_list.include?(@user.id.to_s)
end