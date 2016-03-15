json.time_now Time.now
json.notifications @notifications do |notification|
  json.id notification.id
  json.title notification.title
  json.content notification.content
  json.start_time notification.start_time
 
  json.url notification.url

  if notification.logo.url == "/images/original/missing.png"
    json.logo_url nil
  else
    json.logo_url json.logo_url notification.logo.url
  end
  
end