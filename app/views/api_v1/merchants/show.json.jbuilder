json.merchant_data do
  json.id @merchant.id
  json.merchantable_type @merchant.merchantable_type
  json.merchantable_id @merchant.merchantable_id
  json.name @merchant.name
  json.content @merchant.content
  json.logo_url @merchant.logo.url
  json.price @merchant.price
  
  json.spec_selection @merchant.specs do |spec|
    json.spec_name spec.name
    
    selection_items=[]
    spec.selections.each do |s|
      selection_items << s.name
    end
    
    json.selection_items selection_items
  end 
end
