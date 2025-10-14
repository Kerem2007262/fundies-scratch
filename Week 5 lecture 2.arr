use context starter2024
import math as M
import statistics as S

cafe-data =
  table: day, drinks-sold
    row: "Mon", 45
    row: "Tue", 30
    row: "Wed", 55
    row: "Thu", 40
    row: "Fri", 60
  end

cafe-data

#listing columbia drinks-sold
cafe-data.get-column("drinks-sold")

#make a sample list manually 
sample-list = [list: 2, 3, 4]
sample-list


#make a empty list to add numbers in future 
empty-list = [list: ]
empty-list 




sales = cafe-data.get-column("drinks-sold")

M.max(sales)      # maximum sales
S.mean(sales)     # average sales
M.sum(sales)      # total sold


#make a funtion to multiply the data in list 
fun product(num-list :: List<Number>) -> Number block: 
  doc:"muliply all number in list"
  var result = 1 
  for each(n from num-list):
    result := result * n 
  end
  result
where: 
  product([list: 2,3,4]) is 24 
  product([list: 1,3,2]) is 6 
end 

discount-codes = [list: "NEWYEAR", "student", "NONE", "student", "VIP", "none"]


#remove repeated discount codes 
unique-codes = distinct(discount-codes)
unique-codes


# get rid of all repeats with distinct makes all cap with map
truly-unique-codes = distinct(map(string-to-upper,unique-codes))
truly-unique-codes


#turn list to upper case
upper-codes = map(string-to-upper, unique-codes)
upper-codes

survey-response = [list: "yes", "NO", "maybe", "Yes", "no", "Maybe"]


unique-survey-response = distinct(map(string-to-upper,survey-response ))
unique-survey-response

fun delmaybe(response :: String) -> Boolean:
  not(response == "maybe")
end

bianary-response = filter(delmaybe , unique-survey-response)


#<> is not equal in pyret 
binary-response-lambda = filter(lam(o)->Boolean : not( o == "maybe")end , unique-survey-response)

#create function where only even numbers are registered
 fun is-even(n :: Number) -> Boolean:
  num-modulo(n, 2) == 0
where:
  is-even(6) is true
  is-even(3) is false
end


fun sum-even-numbers(lst :: List) -> Number:
  sum(evens)
  where:
    evens = filter(lam(n): n mod 2 == 0 end, lst)
  end
