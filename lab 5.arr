use context dcic2024
include csv
include data-source

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
  source: csv-table-file("flights_sample53.csv", default-options)

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


#| Task 1- Making a plan for Task 2
   Problem: The column tailnum has empty values with no string.
   
   Planned step: I will be cleaning up the tailnum column by replacing all empty values with unkown. 
   
   Planned Solution: I will be implementing a lambda function using transform-column to complete the planned step. 

