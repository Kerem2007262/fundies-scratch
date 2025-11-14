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

penguins-list

# Step 4: Scaling the data set to answer the afformentioned question.

fun calculating-bmi(penguins :: List<Penguin>) -> List<Number>:
  doc:"Creating a function that will calculate the Penguins BMI"
  cases (List) penguins:
    | empty => empty 
    | link(first, rest) => 
      bmi = first.body_mass_g / num-sqr(first.flipper_length_mm) 
      link(bmi, calculating-bmi(rest))
  end 
end

#Displaying the Scalar result
Penguin_BMI_num = calculating-bmi(penguins-list)

Penguin_BMI_num

