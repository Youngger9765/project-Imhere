json.events @events.each do |event|
  json.id event.id 
  json.name event.name
  json.banner event.banner
  json.logo_url event.logo.url
  json.start_time event.start_time
  json.end_time event.end_time
  json.content event.content
end