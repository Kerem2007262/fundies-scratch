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
  flight          :: String,
  tailnum          :: String,
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


# Task 1- Making a plan for Task 2
#Problem: The column tailnum has empty values with no string.
   
#Planned step: I will be cleaning up the tailnum column by replacing all empty values with unkown. 
   
#Planned Solution: I will be implementing a lambda function using transform-column to complete the planned step.


# Task 2: Handling Missing Data, Cleaning Data, and Identifing Duplicates.

# Step 1; creating a function the transform empty values in the column tailnum to unknown

clean_data = flights.transform-column("tailnum", 
 
  lam(row :: String):  
  
    if row == "": "unknown" 
 
    else: row end 
  end)

# Displaying the Results
 clean_data


#Step 2: Replacing negative values with 0

clean_data2 = transform-column(clean_data, "dep_delay", 
  lam(row :: Number): 
    
    if row < 0: 0 
    
    else: row
    end
  end) 

clean_data3 = transform-column(clean_data2, "arr_delay", 
  lam(row :: Number): 
    
    if row < 0: 0 
    
    else: row
    end
  end)
# displaying the reults
clean_data3 

# Task 3 Identifying Duplicate rows. 

# Step 1: Converting flights to string

# Step 2: Normalizing the characters

carriers_no_space = transform-column(clean_data3, "carrier", lam(s :: String): string-replace(s, " ", "") end)

  carriers_fix = transform-column(carriers_no_space, "carrier", lam(s :: String): string-to-upper(s) end)


# Step 3: Fixing dep_time to fit HH:MM

# Making sure all has a length of 4
length_time_fix = transform-column(carriers_fix,
  "dep_time", lam(s :: Number): 
    str = num-to-string(s)
    if string-length(str) == 3:
      "0" + str
    else: 
      str 
    end 
  end)


# Adding a:
  dep_times_fix = transform-column(length_time_fix, "dep_time", lam(s :: String): string-substring(s, 0, 2) + ":" + string-substring(s, 2, string-length(s)) end)

# Building the dedupkey column
  de_dupkey = build-column(dep_times_fix, "dedup_key", lam(r :: Row): r["flight"] + "-" + r["carrier"] + "-" + r["dep_time"] end)

# Grouping and counting the keys
  group(de_dupkey, "dedup_key")

  count(de_dupkey, "dedup_key")



#Task 4: Visualization and for each loop.

# Step 1 be creating a Frequency bar chart for carriers, histogram for distance, and scatter plot for air time vs distance.

#Creating a frequecy chart
freq-bar-chart(de_dupkey, "carrier")

# Creating a histogram
histogram(de_dupkey, "distance", 2000)

#Creating a scatterplot
scatter-plot(de_dupkey, "air_time", "distance")

# Step 2: creating a list
distance-list = de_dupkey.get-column("distance")

# Step 3: Using a loop

# Calculating total
total = fold(lam(acc, dist): acc + dist end, 0, distance-list)

# Calculating maximum
maximum = fold(lam(acc, dist): if dist > acc: dist else: acc end end, 0, distance-list)
  
  # calculatin avg
  avg = total / length(distance-list)
  
  #Displaying results 
total(distance-list)
maximum(distance-list)
avg(distance-list)




