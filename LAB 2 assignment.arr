use context starter2024

# Function depicting the associated shipping cost added to a order total depending if tis greater than or less than 10$.

#| fun add-shipping(order-amt :: Number) -> Number:
  doc: "add shipping costs to order total"
  if order-amt <= 10:
    order-amt + 4
  else if (order-amt > 10) and (order-amt <= 10): 
    order-amt + 8 
  else: 
    order-amt + 12
  end
where:
  add-shipping(10) is 10 + 4
  add-shipping(3.95) is 3.95 + 4 
  add-shipping(20) is 20 + 8
  add-shipping(10.01) is 10.01 + 8
  add-shipping(30) is 30 + 8 
  add-shipping(32) is 32 + 8
   end |#

# come back to thus function later


hours = 45

if hours <= 40:
  hours * 10
else if hours > 40:
  (40 * 10) + ((hours - 40) * 15)
end

if false: 45 * 10
    else if 45 > 40:
      (40 * 10) + ((45 - 40) * 15)
    end

if 45 > 40:
      (40 * 10) + ((45 - 40) * 15)
    end

if true:
      (40 * 10) + ((45 - 40) * 15)
    end

(40 * 10) + ((45 - 40) * 15)

400 + (5 * 15)