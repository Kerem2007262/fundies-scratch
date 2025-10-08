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

delayed_flight_morning_flight =
  flights.filter(lam(r): is_delayed_departure(r) end)
flights.filter(lam(r): is_morning_sched_dep(r) end)

delayed_flight_morning_flight

# Step 4: Filtering to only keep flights were the distance is > 500
far_morning_delays =
  delayed_flight_morning_flight.filter(lam(r): r["distance"] > 500 end)

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



# Excercise 3: Clean delays + Compute effective speed

# Replace the negative delays with 0 for dep_delay
neg_delay1 = transform-column(flights, "dep_delay",
  lam(d :: Number):
    if d < 0: 
      0 
    else: d 
    end 
  end
  )

# replacing the negative delays with 0 for arr_delay
neg_delay2 = transform-column(flights, "arr_delay",
    lam(d :: Number): 
    if d < 0: 
    0
    else: d 
    end
  end
  )

# Step 2: Adding a column for effecetive speed using Build-column
effective_speed1 =
  build-column(flights, "effective_speed",
    lam(r :: Row):
      if r["air_time"] > 0: 
        r["distance"] / (r["air_time"] / 60)
      else: 
        0
      end
    end)

# Displaying the Results
effective_speed1
neg_delay1
neg_delay2

# Step 3: Ordering the table by effective_speed column
fastest_table = order-by(effective_speed1, "effective_speed", true)

# Step 4: Extracting the carrier, origin, dest of the fastest flight in the data. 
fastest_row = fastest_table.row-n(0)
fastest_carrier = fastest_row["carrier"]
fastest_origin  = fastest_row["origin"]
fastest_dest    = fastest_row["dest"]

"Fastest (cleaned) flight:"
fastest_carrier
fastest_origin
fastest_dest


#Exercise 4: Discount late arrivals + On-Time Score  

# Step 1: defining a function for apply-arrival-discount
fun apply-arrival-discount(t :: Table) -> Table:
  doc:"Creating a function to apply discounts for late arrivals"
  t.transform-column("arr_delay",
    lam(n :: Number): 
      if (n >= 0) and (n <= 45): 
        n * 0.8
      else: n 
      end
    end)
where:
  before = table: arr_delay
    row: -10
    row:   0
    row:  30
    row:  60
  end

  expected = table: arr_delay
    row: -10
    row:   0
    row:  24
    row:  60
  end

  check:
    apply-arrival-discount(before) is expected
  end
end

# Checking the test block
apply-arrival-discount(flights)


# Step 2: Adding a new column on time score

new_table_flights = build-column(flights, "on_time_score", 
  lam(r :: Row) block: 
    score = 0
    if (r["dep_delay"] < 0) and (r["arr_delay"] < 0): 
    0 
    else: 100 - (r["dep_delay"] - r["arr_delay"]) - (r["air_time"] / 30) end 
  if score < 0: 0 
    else: score
  end
  end
  )

new_table_flights

# Step 3 ordering the coolumn for on_time_score (false) and ordering the column distance (true)

dis = order-by(new_table_flights, "distance", true)
score = order-by(new_table_flights, "on_time_score", false)

#displaying the results
dis
score

# Step 4: Extracting the carrier, flight, origin, and dest of the top two flights.
top_2 =
  new_table_flights.row-n(0)
  new_table_flights.row-n(1)

top_carrier = top_2["carrier"]
top_flight  = top_2["flight"]
top_origin  = top_2["origin"]
top_dest    = top_2["dest"]

#Display of Results
"Top two flight based on the following items:"
top_carrier
top_flight
top_origin
top_dest