json.shopify_info do
  json.product_id @merchant.shopify_product_id
  json.variant_id @variant.shopify_variant_id
  json.variant_price @variant.price
  json.weight @variant.weight
  json.weight_unit @variant.weight_unit
end