require_relative './part_1_solution.rb'
  def apply_coupons(cart, coupons)
  data = {}
  cart.each do |cart_item|
    coupons.each do |coupon_item|
      if cart_item[:item] == coupon_item[:item] && cart_item[:count] >= coupon_item[:num]
        data = {
           :item => cart_item[:item]+" W/COUPON",
           :price => coupon_item[:cost]/coupon_item[:num],
           :clearance => cart_item[:clearance],
           :count => coupon_item[:num]
        }
        cart_item[:count] = cart_item[:count] - data[:count]
        cart << data
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |cart_item|
    if cart_item[:clearance] == true
      cart_item[:price] = (cart_item[:price]-cart_item[:price] * 0.20).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  coupon = apply_coupons(cart, coupons)
  data = apply_clearance(coupon)
  
  grand_total = 0
  data.each do |data_item|
    grand_total += data_item[:price] * data_item[:count]
  end
  if grand_total > 100
    grand_total = (grand_total - grand_total * 0.1).round(2)
  end
  grand_total
end
