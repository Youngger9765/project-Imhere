json.orders @orders.each do |order|
  json.shopify_order_number order.order_number
  json.shopify_order_id order.shopify_order_id
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
  json.shipping_price order.shipping_price
  json.total_price order.total_price
  json.currency order.currency

end