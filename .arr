use context starter2024
products = table: item :: String, price :: Number
  row: "Laptop", 1000
  row: "Mouse", 25
  row: "Keyboard", 75
  row: "Monitor", 300
  row: "Headphones", 150
end

products
 

new_price = products.transform-column("price", lam(r :: Number):
    
    if r > 50:
      r * 0.5
     
    else:
      0
    end 
  end)

new_price

prices-orderedby = new_price.order-by("price", false)

prices-orderedby


attendance = table: name :: String, present :: Boolean, homework-done :: Boolean
  row: "Alice", true, true
  row: "Bob", true, false
  row: "Charlie", false, true
  row: "Diana", true, true
  row: "Eve", false, false
  row: "Frank", true, false
end

attendance


attendance_updated = attendance.transform-column("present", lam(r :: Boolean): if r == true: false 

  else: true end end)

attendance_updated

bookings = table: passenger :: String, has-baggage :: Boolean, 
                   is-priority :: Boolean, checked-in :: Boolean
  row: "Alice", true, false, true
  row: "Bob", false, true, true
  row: "Charlie", true, true, false
  row: "Diana", false, false, true
  row: "Eve", true, false, false
  row: "Frank", false, true, true
  row: "Grace", true, true, true
end

bookings

bookings_with_boarding_fee = bookings.build-column("boarding fee", lam(r :: Row): if (r["has-baggage"] == true) and (r["checked-in"] == true): 35 
    else: 0 end 
  end)

bookings_with_boarding_fee

updated_bookings_with_updated_information = bookings_with_boarding_fee.build-column("cannot board", lam(r :: Row): if r["checked-in"] ==  false: "Denied Boarding" else: r end end) 

group_1 = updated_bookings_with_updated_information.build-column("Group 1", lam(r :: Row): if (r["is-priority"] == true) and (r["checked-in"] == true): "Group_1" else: r end end)
  
group_2 = group_1.build-column("Group 2", lam(r :: Row): if (r["is-priority"] == true) and (r["checked-in"] == false): "Group 2" else: r end end)

group_2

Meets_rule = bookings.build-column("new rule", lam(r :: Row): if ((r["has-baggage"] == true) or (r["is-priority"] == true)) and (r["checked-in"] == true): "yes" else: "no" end end)

Meets_rule

#qualified = Meets_rule.filter("new rule", lam(r): r["new rule"] == "yes" end)

#qualified.count()


AQI = table: item :: Number, Index :: String
  
  row: 50, "Good"
  row: 101, "Moderate"
  row: 151, "Unhealthy"
  row: 999, "Hazardous"
end
    AQI

fun Aqi(r :: Number) -> String:
  if r <= 50: "Good" 
  else if r <= 101: "Moderate"
  else if r <= 151: " Unhealthy" 
  else if r <= 152: "Hazardous"
  else: r 
  end
end
  
Aqi(50)
Aqi(101)

basket = table: item :: String, price :: Number, quantity :: Number
row: "apple", 0.50, 10
row: "orange", 0.75, 5
row: "watermelon", 2.99, 2
end


fun add_total(t :: Table) -> Table:
  t.build-column("total", lam( r :: Row): r["price"] * r["quantity"] end)
end 
  
"test"
  add_total(basket)

add_total(basket).filter(lam(r :: Row): r["total"] == 5 end) 

