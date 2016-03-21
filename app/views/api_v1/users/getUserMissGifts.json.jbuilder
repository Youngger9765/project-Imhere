json.miss_merchants @miss_availible_merchants.each do |merchant|
  json.id merchant.id
  
  if merchant.merchantable
    json.activity_name merchant.merchantable.name
  else
    json.activity_name nil
  end

  json.name merchant.name
  json.description merchant.description

  if merchant.logo.url == "/images/original/missing.png"
    json.merchant_logo nil
  else
    json.merchant_logo merchant.logo.url
  end
  
  json.content merchant.content
  json.merchant_price merchant.price
  json.users_count merchant.orders_count
end

json.miss_lotteries @miss_overtime_lotteries.each do |lottery|
  json.id lottery.id
  json.activity_name lottery.activity.name
  json.name lottery.name
  
  if lottery.logo.url == "/images/original/missing.png"
    json.lottery_logo nil
  else
    json.lottery_logo lottery.logo.url
  end

  json.content lottery.content
  json.start_time lottery.start_time
  json.end_time lottery.end_time
  json.status lottery.status
  json.users_count lottery.users_count

end