json.event do
  json.id @event.id 
  json.name @event.name

  if @event.banner.url == "/images/original/missing.png"
    json.banner_url nil
  else
    json.banner_url @event.banner.url
  end

  if @event.logo.url == "/images/original/missing.png"
    json.logo_url nil
  else
    json.logo_url @event.logo.url
  end

end

json.activities @activities.each do |a|
  json.id a.id
  json.status a.status

  if a.logo_in_event.url == "/images/original/missing.png"
    json.logo nil
  else
    json.logo a.logo_in_event.url
  end

  if a.banner.url == "/images/original/missing.png"
    json.logo nil
  else
    json.banner a.banner.url
  end

  json.name a.name
  json.description a.description
  json.achivement a.get_achievement
  json.favoritings_count a.favoritings_count
  json.subdomain a.subdomain
end