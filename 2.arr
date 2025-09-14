use context starter2024
# Task 1: Calculating cost of producing t-shirts
# Defining Constants
s1 = 3
p1 = 12
n1 = 5

# Expression for Total cost for 5 shirts. 
Total1 = s1 + (p1 * n1) 
"Cost of 5 Shirts is " + num-to-string(Total1)

# Re-defining the equation 
s2 = 3
p2 = 12
n2 = 7

#  Expression for Total cost for 7 shirts.
Total2 = s2 + (p2 * n2) 
"Cost of 7 Shirts is " + num-to-string(Total2)

# Task 2:Calculating the cost of the Poster. 

#Defining Constants
W = 420 
H = 594 
P = 0.10

# Creation of the Poster.
perimeter = 2 * (W + H)
"Perimeter is " + num-to-string(perimeter)

# multiplying perimeter by cost
Cost = perimeter * 0.10

"The cost to produce a A2 poster at 0.10$ IS " + num-to-string(Cost) 

#Task 3: String Surprises

T-shirt_Shop_Tagline = "Designs for everyone!"
print(T-shirt_Shop_Tagline)


# Task 4 Expiramenting with colors
("red" + "blue")

# we can conclude that this step in line 43 leads us to conjoin the two color strings together when we run the code.

num-to-string(1) + "blue"
# The action "1 + "blue" leads to a error however when converting the number to a string it leads to a computed solution of "1blue" rather than an error compared to the first action.


# Task 5: Making a Traffic light.

#Defining Terms
g = rectangle(40, 100, "solid", "black")
a = circle(10, "solid", "red")
b = circle(10, "solid", "yellow")
c = circle(10, "solid", "green")

# Stacking Cirlces
stack = above(a, above(b, c))

# Placing stack into rectangle.
traffic = overlay(stack, g)

#Adding a pole at the bottom. 
pole = rectangle(8, 120, "solid", "grey")

#final result
final = above(traffic, pole)

#Final result
final

# Task 6