require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupons.each do |coupon_item|
    cart_num = cart.find_index {|cart_item| cart_item[:item] == coupon_item[:item]}
    if cart_num && cart[cart_num][:count] >= coupon_item[:num]
      cart << {item: "#{cart[cart_num][:item]} W/COUPON", price: coupon_item[:cost] / coupon_item[:num], clearance: cart[cart_num][:clearance], count: (cart[cart_num][:count] / coupon_item[:num]).to_i * coupon_item[:num]}
      cart[cart_num][:count] %= coupon_item[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.map { |cart_item| cart_item[:price] = (cart_item[:price] * 0.80).round(2) if cart_item[:clearance] == true}
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  cart_total = cart.sum {|cart_item| cart_item[:price] * cart_item[:count]}
  cart_total > 100 ? cart_total * 0.9 : cart_total
end
