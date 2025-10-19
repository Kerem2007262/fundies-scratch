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