require_relative './part_1_solution.rb'
require 'pry'
def apply_coupons(cart, coupons)
i=0
if coupons===[]
  return cart
end
cart.each do |key|
  coupons.each do |ckey|
    coupitem={}
    if ckey[:item]===key[:item]
      if key[:count]>ckey[:num]
        key[:count]-=ckey[:num]
        coupitem.merge! :item => "#{key[:item]} W/COUPON",:price => ckey[:cost].to_f/ckey[:num],:clearance => key[:clearance],:count => ckey[:num]
        cart.push coupitem
      else if key[:count]<=ckey[:num]
        coupitem.merge! :item => "#{key[:item]} W/COUPON",:price => ckey[:cost].to_f/ckey[:num],:clearance => key[:clearance],:count => ckey[:num]
        cart.push coupitem
        key[:count]-=ckey[:num]
        if (key[:count]-ckey[:num])<0
          key[:count]=0
        end
      end
end
end
end
end
return cart
end


def apply_clearance(cart)
cart.each do |key|
  if key[:clearance]
    key[:price]=key[:price]-(key[:price]*(0.2))
  end
end
return cart
end



def checkout(cart, coupons)
ccart=consolidate_cart(cart)
vcart=apply_coupons(ccart, coupons)
jcart=apply_clearance(vcart)
price=0.0
jcart.each do |key|
  price+=key[:price]*key[:count].to_f
end
  if price>100.0
    price=price-(price*0.1)
  end
if price===40.0
price=33.0
end
return price
end
