use context dcic2024

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
  doc:"creating a function that checks the following conditionals in rocks, paper, scissors."
  
  if (p1 == "paper") and (p2 == "rock"):
    "p1 wins."
  else if (p1 == "scissors") and (p2 == "rock")
    "p2 wins" 
    else: 
    "tie"
    end
   
    

where:
  # Ties
  rock-paper-scissors("rock", "rock") is "tie"
  rock-paper-scissors("paper", "paper") is "tie"
  rock-paper-scissors("scissors", "scissors") is "tie"

  # Player 1 wins
  rock-paper-scissors("rock", "scissors") is "player 1"
  rock-paper-scissors("paper", "rock") is "player 1"
  rock-paper-scissors("scissors", "paper") is "player 1"

  # Player 2 wins
  rock-paper-scissors("scissors", "rock") is "player 2"
  rock-paper-scissors("rock", "paper") is "player 2"
  rock-paper-scissors("paper", "scissors") is "player 2"
end