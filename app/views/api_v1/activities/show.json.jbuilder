json.activity_data do
  json.id @activity.id
  json.name @activity.name
  json.status @activity.status
  json.logo_url @activity.logo.url
  json.participator @activity.participator
  json.start_time @activity.start_time
  json.end_time @activity.end_time
  json.location @activity.location
end

json.activity_milestones @milestones

json.activity_content do
  json.content @activity.content
end

json.activity_info do
  json.information @activity.information
  json.information_pic @activity.information_picture.url
  json.participator @activity.participator
  json.start_time @activity.start_time
  json.end_time @activity.end_time
  json.location @activity.location
end

json.activity_merchants @merchants.each do |merchant|
  json.id merchant.id
  json.name merchant.name
  json.description merchant.description
end
  


  
  