json.event do
  json.id @event.id 
  json.name @event.name
  json.banner_url @event.banner.url
  json.logo_url @event.logo.url
end

json.activities @activities.each do |a|
  json.id a.id
  json.status a.status
  json.logo a.logo.url
  json.name a.name
  json.description a.description
end