use context dcic2024
include tables
include file

# Excercise 1, designing a function to determine if given year is a leap year .

fun leap-year(year :: Number) -> Boolean:
  
  doc: "Creating a conditional function that is designed to check if a given year is a leap year or not based on the following conditions that it is divisible by 400, 100, and 4."
 
  if num-modulo(year, 400) == 0:
    true
  else if num-modulo(year, 100) == 0:
    false
  else if num-modulo(year, 4) == 0:
    true 
  else:
    false
end

where:
leap-year(2000) is true 
leap-year(2020) is true
leap-year(1900) is false
leap-year(2021) is false
end



# Excercise 2, Making a clock

fun tick(sec :: Number):
  
  doc: "creating a function that represents the characteristics of a clock through representation of its ticks."
  
  if (sec >= 0) and (sec < 59):
   sec + 1 
  else if (sec < 0):
    "false"
  else if (sec == 59):
    0
  end
    
 where:
  tick(0) is 1
  tick(58) is 59
  tick(59) is 0
end
    


# Excercise 3, rock-paper-scissors
fun rock-paper-scissors(p1 :: String , p2 :: String) -> String:
  doc: "creating a function that checks the following conditionals in rock, paper, scissors."

  # Conditionals that lead to Player 1 wining
  if (p1 == "paper") and (p2 == "rock"):
    "p1 wins"
  else if (p1 == "scissors") and (p2 == "paper"):
    "p1 wins"
  else if (p1 == "rock") and (p2 == "scissors"):
    "p1 wins"

    # Conditionals that lead to Player 2 wining
  else if (p1 == "rock") and (p2 == "paper"):
    "p2 wins"
  else if (p1 == "paper") and (p2 == "scissors"):
    "p2 wins"
  else if (p1 == "scissors") and (p2 == "rock"):
    "p2 wins"
 
    # Conditionals that lead to a tie
  else if (p1 == "rock") and (p2 == "rock"):
    "tie"
  else if (p1 == "paper") and (p2 == "paper"):
     "tie"
  else if (p1 == "scissors") and (p2 == "scissors"):
     "tie"   
    
  # Anything else is invalid input
  else:
    "invalid input"
  end

where:
  # Tie cases
  rock-paper-scissors("rock", "rock") is "tie"
  rock-paper-scissors("paper", "paper") is "tie"
  rock-paper-scissors("scissors", "scissors") is "tie"

  # Player 1 wins
  rock-paper-scissors("rock", "scissors") is "p1 wins"
  rock-paper-scissors("paper", "rock") is "p1 wins"
  rock-paper-scissors("scissors", "paper") is "p1 wins"

  # Player 2 wins
  rock-paper-scissors("scissors", "rock") is "p2 wins"
  rock-paper-scissors("rock", "paper") is "p2 wins"
  rock-paper-scissors("paper", "scissors") is "p2 wins"
end


# Excercise 4, Planets
# creating a table to enter the given data on Planets and their relative distance. 

Planet = table: planet, distance
  row: "Mercury", 0.39
  row: "Venus", 0.72
  row: "Earth", 1.00
  row: "Mars", 1.52
  row: "Jupiter", 5.20
  row: "Saturn", 9.54
  row: "Uranus", 19.2
  row: "Neptune", 30.06
end

Planet

# Extracting row 3 (Mars is index 3, since 0 is "Mercury")

mars = Planet.row-n(3)

mars

# Extract the distance from Mars row
mars-distance = mars["distance"]

"Mars Distance"
mars-distance



# Excerise 5, Bank of England

Bank = load-table:
  year :: Number,
  day :: Number,
  month :: String,
  rate :: Number
  source: csv-table-file("boe_rates.csv", default-options)

  sanitize year using num-sanitizer
  sanitize day using num-sanitizer
  sanitize rate using num-sanitizer
end

Bank.length()
median(Bank, "rate")
mean(Bank, "rate")
order-by(Bank, "rate", true)