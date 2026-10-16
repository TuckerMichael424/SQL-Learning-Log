#Using the print function. 
print('Hello World!')
#Using arithmetic with the print function. 
print(1 + 2)
print(4-9)
#Arithmetic using the PEMDAS order of operations. 
print(((1 + 3) * (9 - 2) / 2) **2)

#Create variables using the = sign. 
test_var = 4 + 5

#Print the value of test_var
print(test_var)

#Manipulating variables by changing their value. 
#Set the value of a new vartiable to 3
my_var = 3

#Print the value assigned to my_var
print(my_var)

#Change the value of the variable to 100. 
my_var = 100

#Print the new value assigned to my_var
print(my_var)
print(test_var)

#Increase the value of my_var by 3
my_var = my_var + 3

#Print the new value assigned to my_var above. 
print(my_var)

#Define different variables.
num_years = 4
days_per_year = 365
hours_per_day = 24
mins_per_hour = 60
sec_per_min = 60

#Calculate the number of seconds in four years using the above variables. 
total_secs = sec_per_min * mins_per_hour * hours_per_day * days_per_year * num_years
print(total_secs)

# Update to the above to include leap years. 
days_per_year = 365.25

# Calculate number of seconds in four years with leap years accounted. 
total_secs = sec_per_min * mins_per_hour * hours_per_day * days_per_year * num_years
print(total_secs)

#Debugging due to typos
print(hours_per_dy)
print(hours_per_day)