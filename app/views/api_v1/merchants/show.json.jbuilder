json.merchant_data do
  json.id @merchant.id
  json.merchantable_type @merchant.merchantable_type
  json.merchantable_id @merchant.merchantable_id
  json.name @merchant.name

  if @merchant.banner.url == "/images/original/missing.png"
    json.banner_url nil
  else
    json.banner_url @merchant.banner.url
  end

  json.content @merchant.content
  json.handle @merchant.handle

  if @merchant.logo.url == "/images/original/missing.png"
    json.logo_url nil
  else
    json.logo_url @merchant.logo.url
  end

  json.price @merchant.price

  json.spec_selection @merchant.specs do |spec|
    json.spec_name spec.name

    selection_items=[]
    spec.selections.each do |s|
      selection_items << s.name
    end

    json.selection_items selection_items
  end

  json.sponsor @merchant.sponsor
end
