json.orders @orders.each do |order|
  json.shopify_order_id order.order_number
  json.merchant_name order.product_name
  

  if order.merchant.logo.url == "/images/original/missing.png"
    json.merchant_logo nil
  else
    json.merchant_logo order.merchant.logo.url
  end

  json.merchant_variant order.product_variant_title
  json.merchant_price order.product_price
  json.quantity order.product_quantity
  json.subtotal_price order.subtotal_price
  json.created_at order.created_at
  json.shipping_method order.shipping_method
  json.address order.address
  json.shipping_price order.shipping_price
  json.total_price order.total_price
  json.currency order.currency
  json.fulfillment_status order.fulfillment_status

end

json.lotteries @lotteries.each do |lottery|
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
  json.fulfillment_status lottery.fulfillment_status

end