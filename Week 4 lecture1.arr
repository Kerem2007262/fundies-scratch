use context dcic2024
include csv
include data-source

# creating tables
orders = table: time, amount
  row:"08:00", 10.5
  row:"09:30", 5.75
  row:"10:15", 8.00
  row:"11:00", 3.95
  row:"14:00", 4.95
  row:"16:45", 7.95
end

orders

fun is-high-value(o :: Row) -> Boolean:
  # we are passing a value that returns a boolean, also indexing starts at 0 meaning row 1 is really jsut 0.
  o["amount"] >= 8.0
where: 
  is-high-value(orders.row-n(2)) is true
  is-high-value(orders.row-n(3)) is false
  # row three is false becasue it isn't greater.
end

#filter-with :: (t :: Table, keep :: (Row -> Boolean)) -> Table
new-high-orders = filter-with(orders, is-high-value) 

new-high-orders

filter-with(orders, lam(o): o['amount'] >= 8.0 end)

# first task
filter-with(orders, lam(o): o['time'] > "12:00" end)

# From URL
Photos = load-table:
  Location:: String,
  Subject :: String,
  Date :: String
  source: csv-table-url("https://raw.githubusercontent.com/neu-pdi/cs2000-public-resources/refs/heads/main/static/support/7-photos.csv", default-options)
end

Photos

is-forest = filter-with(Photos, lam(o): o['Subject'] == "Forest" end)

is-forest

forest-is = order-by(Photos, "Location", false)

location-count = count(Photos, "Location")

order-by(location-count, "count", false)

freq-bar-chart(Photos, "Location")