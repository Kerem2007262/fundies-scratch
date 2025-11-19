use context dcic2024

include csv
include data-source




# Step 1: Defining the Data type for Penguin.
data Penguin:
  | penguin(
  species           :: String,
  island            :: String, 
  bill_length_mm    :: Number, 
  bill_depth_mm     :: Number, 
  flipper_length_mm :: Number, 
  body_mass_g       :: Number,
  sex               :: String, 
  year              :: Number)
end  



# Step 2: Importing Data Table of Penguin.CSV into the file
Penguins = load-table:
  id                :: Number,
  species           :: String,
  island            :: String, 
  bill_length_mm    :: Number, 
  bill_depth_mm     :: Number, 
  flipper_length_mm :: Number, 
  body_mass_g       :: Number,
  sex               :: String, 
  year              :: Number
source: csv-table-file("penguins.csv", default-options)
    
# Sanatizing the Numbers in the data set
  sanitize id                using num-sanitizer
  sanitize bill_length_mm    using num-sanitizer
  sanitize bill_depth_mm     using num-sanitizer
  sanitize flipper_length_mm using num-sanitizer
  sanitize body_mass_g       using num-sanitizer
  sanitize year              using num-sanitizer
end
 


# Displaying the Table before moving on to List Techniques to ensure data works.
Penguins
    



# TASK 1 Scalar Processing


# Step 3: Coding the first list technique, Scalar Processing to answer the following question, "What is the BMI of each penguin in my dataset?" using the given data set. (The design Recipie for this question can be found on the report.)

# Convert Penguins table to list.
fun penguin-to-list(row):
  
 doc:"Creating a fucntion that converts the table into a list to allow me to complete the scalar process."
  
  penguin(row["species"], row["island"], row["bill_length_mm"],
          row["bill_depth_mm"], 
    
row["flipper_length_mm"], row["body_mass_g"],
          row["sex"], row["year"])
end

# Mapping the table rows into a list and storing them.
penguins-list = map(penguin-to-list, Penguins.all-rows())

#penguins-list



# Step 4: Scaling the data set to answer the afformentioned question.
fun round-digits(number :: Number, decimals :: Number) -> Number:
 
  doc: "This is a helper function designed to round off the decimal places, this function was created after realizing the that the values calculated with the function 'calculating-bmi' were too large."
  
  multiplier = num-expt(10, decimals)
  num-round(number * multiplier) / multiplier
end

fun calculating-bmi(penguins :: List<Penguin>) -> List<Number>:
  doc: "Creating a function that will calculate the Penguins BMI"
  cases (List) penguins:
    | empty => empty 
    | link(first, rest) => 
      bmi = first.body_mass_g / num-sqr(first.flipper_length_mm) 
      rounded-bmi = round-digits(bmi, 4)
      link(rounded-bmi, calculating-bmi(rest))
  end 
where:
  # Test 1: Empty list
  calculating-bmi(empty) is empty
  
  # Test 2: One penguin test Adeline 
  adelie-test = penguin("Adelie", "Torgersen", 39.1, 18.7, 181, 3750, "male", 2007)
  result = calculating-bmi([list: adelie-test])
  list.length(result) is 0.1145
  
  # Test 3: Two penguins test
  calculating-bmi("Adelie", "Torgersen", 39.5, 17.4, 186, 3800, "female", 2007) is 0.1098

 
end


#Displaying the Scalar result
Penguin_BMI_num = calculating-bmi(penguins-list)

Penguin_BMI_num 





# Task 2 Transformation Process

# Step 5:  Coding the second list technique, transforming the data set to answer the following question, "How can I convert all penguin species body masses from grams to kilograms?" (The design Recipie for this question can be found on the report.)

fun transform_body_mass_to_kg(penguins :: List<Penguin>) -> List<Penguin>:

  doc:"Creating a function that converts Body mass in grams of the penguins into Kg."
  
  cases (List) penguins:
    | empty => empty
    | link(first, rest) =>
      mass-in-kg = round-digits(first.body_mass_g / 1000, 4)
      new-penguin = penguin(first.species, first.island,
        first.bill_length_mm, first.bill_depth_mm, 
first.flipper_length_mm, mass-in-kg,first.sex, first.year)
      link(new-penguin, transform_body_mass_to_kg(rest))
  end
end

#Displaying the Result -> ask if we have to put screen show of display of result in report. 

Penguin_new = transform_body_mass_to_kg(penguins-list)

Penguin_new



# Task 3: Selection 

# Step 6:  Coding the third list technique, selecting the data set to answer the following question, "Which Penguin in the data set are considered heavy (body mass greater than 4.5 kg or 3500 grams)?" (The design Recipie for this question can be found on the report.) 

fun heavy-penguins(penguins_selection_heavy :: List<Penguin>) -> List<Penguin>:
  
  doc:"Creating a fnction that slects penguins that weigh greater than 4.5kg."
  
  cases (List) penguins_selection_heavy:
    |empty => empty
    |link(first, rest) =>
     
      if first.body_mass_g > 4.5:
        link(first, heavy-penguins(rest)) 
        
      else:
        heavy-penguins(rest)
        
      end
  end
end 

# Displaying the Results.
Penguin_selection_heavy_new = heavy-penguins(Penguin_new)

Penguin_selection_heavy_new




#Task 4: Accumulation

# Step 7: Coding the Final technique,  selecting the data set to answer the following question, "What is the average flipper length in mm of of the Adelie penguin species across all three islands?" (The design Recipie for this question can be found on the report.) 

# Step 8: Filtering the original data table to include only the species I will be examining be the Adelie species. 

Adelie_species = Penguins.filter(lam(p): p["species"] == "Adelie" end)

# Displaying the filtered table
Adelie_species

# Convert Penguins table to list.
fun Adelie-to-list(row):
  
 doc:"Creating a fucntion that converts the table into a list."
  
  penguin(row["species"], row["island"], row["bill_length_mm"],
          row["bill_depth_mm"], 
    
row["flipper_length_mm"], row["body_mass_g"],
          row["sex"], row["year"])
end

Adelie-list = map(Adelie-to-list, Adelie_species.all-rows())

# Step 9: Accumelating the flipper length of the Adelie species across all 3 islands (Torgersen, Biscoe, and Dream).


fun sum-flipper-length-by-island(penguins :: List<Penguin>, island :: String) -> Number:
  doc:" Creating a function that gets the sum of the flipper lengths by each island (Torgersen, Biscoe, and Dream)."
  cases (List) penguins:
    |empty => 0
    |link(first, rest) =>
      
      if first.island == island:
        
        first.flipper_length_mm + sum-flipper-length-by-island(rest, island) 
        
        else:
        sum-flipper-length-by-island(rest, island)
end 

  end 

end
  



fun count-penguins-island(penguins :: List<Penguin>, island :: String) -> Number:
  
  doc:"Creating a function that counts the number of Adelie species penguin on each respective island."
  
  cases (List) penguins:
    |empty => 0
    |link(first, rest) =>
      
      if first.island == island:
        
        1 + count-penguins-island(rest, island)
        
        else:
        count-penguins-island(rest, island)
end 

  end 

end



fun avg-flipper-length-by-island(penguins :: List<Penguin>) -> List<Number>:
  
  doc:"Creating a function that calculates the average flipper length of the Adelie species by each respective island using the helper functions above 'sum-flipper-length-by-island' and 'count-penguins-island'."
 
  torgersen_total = sum-flipper-length-by-island(penguins, "Torgersen")
  
  torgersen_count = count-penguins-island(penguins, "Torgersen")
  
  torgersen_avg = round-digits(torgersen_total / torgersen_count, 2)
  
 
  biscoe_total = sum-flipper-length-by-island(penguins, "Biscoe")
  
  biscoe_count = count-penguins-island(penguins, "Biscoe")
  
  biscoe_avg = round-digits(biscoe_total / biscoe_count, 2)
  
  dream_total = sum-flipper-length-by-island(penguins, "Dream")
  
  dream_count = count-penguins-island(penguins, "Dream")
  
  dream_avg = round-digits(dream_total / dream_count, 2)
  
  #Returning a list of all averages
  [list: torgersen_avg, biscoe_avg, dream_avg]
end 

#Displaying results for Adelie penguins on different islands with their avg flipper length.

avg_islands = avg-flipper-length-by-island(Adelie-list)

avg_islands
  
