use context starter2024
# Task 1 creating a orange truangle
orange-triangle = triangle(35, 'solid', 'orange')

# displaying the final result. 
orange-triangle

# Task 2 creating a blue square.
# Defining a side-length, anf color.
sqr_length = 60
sqr_color = "blue"
blue-square = square(sqr_length, "solid", sqr_color)

# Displaying Blue Square
blue-square 

#Task 3 

fun Welcome(name):
  "welcome to class," + name
end

Welcome("Jaden")

fun area(width, height):
  width * height
end

check:
  area(5, 4) is 5 * 4
  area(2, 3) is 2 * 3
end

fun shirt-cost(quantity :: Number, length-msg :: String) -> Number:
  #calculation part
  string-l = string-length(length-msg)
  (quantity * 5) + (string-l * 0.1) 
end

shirt-cost(4, 'Go Team!')
shirt-cost(7, 'Hello World')

CTF = 9/5
constant = 32

fun celcius-to-farenheit(c :: Number) -> Number:
  #calcultion part
  (c * CTF) + constant
end
 celcius-to-farenheit(0)

fun farenheit-to-celcius(c :: Number) -> Number:
  #calcultion part
  (c - 32) * 5/9
end

farenheit-to-celcius(32)