json.events @events.each do |event|
  json.id event.id 
  json.name event.name
  json.banner event.banner
  json.logo_url event.logo.url
end