json.favoritings_count @favoritings_count

json.activities @activities.each do |a|
  json.id a.id
  json.name a.name
  
  json.artists a.artists.each do |artist|
    json.artist_name artist.name
  end

  json.start_time a.start_time
  json.end_time a.end_time
  json.status a.status

end