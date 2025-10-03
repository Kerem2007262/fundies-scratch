use context dcic2024
items = table: item :: String, x-coordinate :: Number, y-coordinate :: Number
  row: "Sword of Dawn",           23,  -87
  row: "Healing Potion",         -45,   12
  row: "Dragon Shield",           78,  -56
  row: "Magic Staff",             -9,   64
  row: "Elixir of Strength",      51,  -33
  row: "Cloak of Invisibility",  -66,    5
  row: "Ring of Fire",            38,  -92
  row: "Boots of Swiftness",     -17,   49
  row: "Amulet of Protection",    82,  -74
  row: "Orb of Wisdom",          -29,  -21
end

items

# creating a function to substract -1 from the coulmn.
fun subtract-1(n :: Number) -> Number:
  doc: "substracts 1 from input"
  n - 1
where:
  subtract-1(10) is 9
  subtract-1(0) is -1
  subtract-1(-3.5) is -4.5
end

moved-items = transform-column(items, "x-coordinate", subtract-1)

moved-items

# Task 1
fun pull-closer(n :: Number) -> Number: 
  doc: "multiples coordinates by 0.9 to pull 10% closer to the origin"
  n * 0.9
where:
  pull-closer(10) is 9
  pull-closer(-20) is -18 
  pull-closer(0) is 0
end

#Apply transformation to both x and y coordinates
items-pulled-closer = transform-column(transform-column(items, "x-coordinate", pull-closer), "y-coordinate", pull-closer)
items-pulled-closer

# Building a new-column

fun calc-distance(n :: Row) -> Number:
  doc:"Creating a function to calculate the distance of the players"
  num-sqrt(num-sqr(n["x-coordinate"])) + num-sqr(n["y-coordinate"])
where: calc-distance(items.row-n(0)) is num-sqrt(num-sqr(23)) + num-sqr(-87)
      
  calc-distance(items.row-n(3)) is num-sqrt(num-sqr(-9)) + num-sqr(64)
end

# find the closest item to the player
items-with-dist = build-column(items, "distance-squared", calc-distance)
items-sorted = order-by(items-with-dist, "distance-squared", true)
closest-item-name = items-sorted.row-n(0)["item"]

#display results
items-with-dist
closest-item-name
      
 
      
      # to get the coordinates from the row we have to use the name of the row and in square brakcets we put the column name. 

fun obfuscate(n :: String) -> String:
  doc:"calculating the length of each item in the table"
  string-repeat("X", string-length(n))
end

Unamed = transform-column(items, "item", obfuscate)
