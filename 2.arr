use context starter2024
# Task 1: Calculating cost of producing t-shirts

# Defining Constants
s1 = 3
p1 = 12
n1 = 5

# Expression for Total cost for 5 shirts. 
Total-1 = s1 + (p1 * n1) 
"Cost of 5 Shirts is " + num-to-string(Total-1)

# Re-defining the equation 
s2 = 3
p2 = 12
n2 = 7

#  Expression for Total cost for 7 shirts.
Total-2 = s2 + (p2 * n2) 
"Cost of 7 Shirts is " + num-to-string(Total-2)

# Task 2:Calculating the cost of the Poster. 

# Defining Constants
W = 420 
H = 594 
P = 0.10

# Creation of the Poster.
perimeter = 2 * (W + H)

"Perimeter is " + num-to-string(perimeter)

# multiplying perimeter by cost
Cost = perimeter * 0.10

# Final Result
"The cost to produce a A2 poster at 0.10$ IS " + num-to-string(Cost) 

# Task 3: String Surprises
"Designs for everyone!"


# Task 4 Expiramenting with colors
("red" + "blue")

# we can conclude that this step in line 43 leads us to conjoin the two color strings together when we run the code.

num-to-string(1) + "blue"
# The action "1 + "blue" leads to a error however when converting the number to a string it leads to a computed solution of "1blue" rather than an error compared to the first action.


# Task 5: Making a Traffic light.

# Creating the Shapes needed for the Traffic light.
g = rectangle(40, 100, "solid", "black")
a = circle(10, "solid", "red")
b = circle(10, "solid", "yellow")
c = circle(10, "solid", "green")

# Stacking Cirlces
stack = above(a, above(b, c))

# Placing stack into rectangle.
traffic_light = overlay(stack, g)

# Adding a pole at the bottom. 
pole = rectangle(8, 120, "solid", "grey")

# Final result
final = above(traffic_light, pole)

# Final result
final

# Task 6: broken code hunt
rectangle(50, 20, "solid", "black")

circle(30, "solid", "red")

# The issue with the first code (line 76) was that the code order was misplaced, as a result, the code didn't fnction as it was supposed to. Adding on, the underlying problem with the second code (line 78) was that a string wasn't used to denote the color. Therefore, leading to a error in the code action. 


# Task 7: creating a Flag or a Shield
# generating shapes needed for the flag
f1 = rectangle(150, 100, "solid", "dark green")
f2 = circle(40, "solid", "red")
f3 = star(30, "solid", "blue")

#overlaying the shapes together.
overlay(f3, overlay(f2, f1))



 

