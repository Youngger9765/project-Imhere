json.today @date_now
json.today_notifications @notifications do |notification|
  json.id notification.id
  json.title notification.title
  json.content notification.content
  json.start_time notification.start_time
  json.countdown_end_time notification.countdown_end_time
 
  json.url notification.url

  if notification.logo.url == "/images/original/missing.png"
    json.logo_url nil
  else
    json.logo_url json.logo_url notification.logo.url
  end
  
end