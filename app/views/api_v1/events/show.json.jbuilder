json.event do
  json.id @event.id 
  json.name @event.name
  json.banner @event.banner
  json.logo_url @event.logo.url
  json.start_time @event.start_time
  json.end_time @event.end_time
  json.content @event.content
end

json.activities @activities.each do |a|
  json.id a.id
  json.status a.status
  json.logo a.logo.url
  json.name a.name
  json.participator a.participator
  json.location a.location
  json.start_time a.start_time
  json.end_time a.end_time
  json.content a.content
  json.information a.information
  json.information_pic a.information_picture.url
end