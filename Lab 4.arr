use context dcic2024
include csv
include data-source

#Excercise 1 - Long Flights

# Step 1: Loading the Flights CSV Table 
flights = load-table:
  rownames        :: Number,
  dep_time        :: Number,
  sched_dep_time  :: Number,
  dep_delay       :: Number,
  arr_time        :: Number,
  sched_arr_time  :: Number,
  arr_delay       :: Number,
  carrier         :: String,
  tailnum         :: String,
  flight          :: String,
  origin          :: String,
  dest            :: String,
  air_time        :: Number,
  distance        :: Number,
  hour            :: Number,
  minute          :: Number,
  time_hour       :: String
  source: csv-table-file("flights.csv", default-options)

# Sanatizing the Numbers in the data set
  sanitize rownames        using num-sanitizer
  sanitize dep_time        using num-sanitizer
  sanitize sched_dep_time  using num-sanitizer
  sanitize dep_delay       using num-sanitizer
  sanitize arr_time        using num-sanitizer
  sanitize sched_arr_time  using num-sanitizer
  sanitize arr_delay       using num-sanitizer
  sanitize air_time        using num-sanitizer
  sanitize distance        using num-sanitizer
  sanitize hour            using num-sanitizer
  sanitize minute          using num-sanitizer
end

# loading the table titles "flights"
flights


# Step 2: Defining a predicate
fun is_long_flight(row :: Row) -> Boolean:
  doc: "Checks if the flight distance is greater than or equal to 1500"
  row["distance"] >= 1500
end

# Step 3: Filter the long flights
long_flights = filter-with(flights, is_long_flight)

long_flights

# Step 4: Order results by air_time 
ordered_flights = order-by(long_flights, "air_time", true)

ordered_flights

# Step 5: Extract carrier, origin, and dest of the first flight
top = ordered_flights.row-n(0)

carrier = top["carrier"]
origin  = top["origin"]
dest    = top["dest"]

"Longest flight info:"
carrier
origin
dest


# Excercise 2 - Delayed Morning Flights

# Step 1: Defining a Predicate
fun is_delayed_departure(r :: Row) -> Boolean:
  doc: "finding flights that were delayed buy atleast 30 mins"
  r["dep_delay"] >= 30
end

# Step 2: Defining another predicate
fun is_morning_sched_dep(r :: Row) -> Boolean:
  doc:"Checks is departue time is before noon"
  r["sched_dep_time"] < 1200
end

# Step 3:using Lambda

delayed_and_morning =
  flights
    .filter(lam(r): is_delayed_departure(r) end)
    .filter(lam(r): is_morning_sched_dep(r) end)

delayed_and_morning

# Step 4: Filtering to only keep flights were the distance is > 500
far_morning_delays =
   delayed_and_morning.filter(lam(r): r["distance"] > 500 end)

# Step 5: order by dep_delay descending (worst delays first)
worst_delays =
  order-by(far_morning_delays, "dep_delay", false)

# Step 6: taking the single worst delayed flight and extract fields
worst = worst_delays.row-n(0)

worst_flight = worst["flight"]
worst_origin = worst["origin"]
worst_dep_delay = worst["dep_delay"]

"Single worst delayed (morning & >500mi) flight:"
worst_flight
worst_origin
worst_dep_delay


