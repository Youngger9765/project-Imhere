json.events @events.each do |event|
  json.id event.id 
  json.name event.name

  if event.banner.url == "/images/original/missing.png"
    json.banner_url nil
  else
    json.banner_url event.banner.url
  end

  if event.logo.url == "/images/original/missing.png"
    json.logo_url nil
  else
    json.logo_url event.logo.url
  end

end