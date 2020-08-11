require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  cart.each do |cart_items|
    coupons.each do |coupon_items|
      if cart_items[:item] == coupon_items[:item] && cart_items[:count] >= coupon_items[:num]
          cart_items[:count] -= coupon_items[:num]
          cart << {
            item: cart_items[:item] + " W/COUPON",
            price: coupon_items[:cost] / coupon_items[:num],
            clearance: cart_items[:clearance],
            count: coupon_items[:num]
            }
      end
      #if cart_items[:count] == 0
      #  cart.delete(cart_items)
      #end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |cart_items|
    if cart_items[:clearance] == true
      cart_items[:price] = (cart_items[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  total_price = 0
  new_cart = consolidate_cart(cart)
  new_coupon_cart = apply_coupons(new_cart, coupons)
  finished_cart = apply_clearance(new_coupon_cart)
  finished_cart.each do |items|
    cost_by_item = items[:price] * items[:count]
    total_price += cost_by_item
  end
  if total_price > 100
    total_price *= 0.9
  end
  total_price
end
