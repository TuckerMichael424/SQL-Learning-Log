# **** FUNCTIONS ****

# Functions are pre-defined actions built into Python's code

#Define a simple function. 
def add_three(input_var):
    output_var = input_var + 3
    return output_var

add_three(10)
print(f"Adding 3 to 10 gives us: {add_three(10)}\n ")


#Run the function defined above with 10 as the input. 
new_number = 18

add_three(new_number)

#Check that the value is 13, as expected. 
print(f"Changing the number from 10 to new_number, which is {new_number}, gives us: {add_three(new_number)}")
"\n"

#Now a function that will calculate a friend's wekely paycheck after taxes. 12% tax bracket, $15 an hour. 
def get_pay(num_hours):
    #Pre-tax pay, based on receiving $15/hour. 
    pay_pretax = num_hours * 15
    #After-tax pay, based on being in 12% tax bracket. 
    pay_aftertax = pay_pretax * (1 - .12)
    return pay_aftertax

#Calculate pay based on working 40 hours. 
pay_fulltime = get_pay(40)
print(pay_fulltime)

#Functions can have multiple arguments that are separated by commas within the parenthesis. 
def get_pay_with_more_inputs(num_hours, hourly_wage, tax_bracket):
    #Pre-tax pay
    pay_pretax = num_hours * hourly_wage
    #After-tax pay. 
    pay_aftertax = pay_pretax * (1 - tax_bracket)
    return pay_aftertax

#Now that the function is defined, you need to provide one value for each input/argument
higher_pay_aftertax = get_pay_with_more_inputs (40, 24, .22)
print(higher_pay_aftertax)

#Below are some exercises I had ChatGPT come up with. 
#Exercise 1: Simple Addition Function
# TODO: Define the add_numbers function
def add_numbers(num1, num2):
    add_numbers = num1 + num2
    return add_numbers

# Test the function
result = add_numbers(5, 3)
print(result)

#Exercise 2: Calculate Area
def calculate_area(length, width):
    calculate_area = length * width
    return calculate_area

# Test the function
area = calculate_area(10, 5)
print(area)

#Exercise 3: String Repeater
# Define the repeat_string function
def repeat_string(string, n):
    repeat_string = string * n
    return repeat_string

# Test the function
result_string = repeat_string("Hello ", 5)
print(result_string)

#Exercise 4: Check Even or Odd
# Define the is_even function
def is_even(number):
    is_even = number % 2 == 0
    #I was setting the statement to "is_even = % 2 == 0" at first, which was neglecting the variable number in processing the function. Once I added it, the function worked. 
    return is_even

# Test the function
even_result = is_even(8)
print(even_result)

#Exercise 5: Celsius to Farenheit Converter
# Define the celsius_to_fahrenheit function
def celsius_to_fahrenheit(celsius):
    celsius_to_fahrenheit = (celsius * 9/5) + 32
    return celsius_to_fahrenheit

# Test the function
fahrenheit_temp = celsius_to_fahrenheit(25)
print(fahrenheit_temp)

#Some examples pulled from Blackbox.ai
def multiply_numbers (a,b):
    return a * b

multiply_numbers(5, 10)

def area_of_circle(radius):
    area_of_circle = radius ** 3.14
    return area_of_circle

area_of_circle(4)
print(area_of_circle)

"\n"

def calculate_sum(durations):
    if len(durations) == 0:
        return{"error": "No rides to summarize"}
    # Total rides calc
    total_rides = len(durations)
    
    # Total minutes calc
    total_minutes = sum(durations)
    
    # Average minutes calc
    avg_minutes = round(total_minutes / total_rides,)
    
    return {
        "total_rides": total_rides, 
        "total_minutes": total_minutes,
        "average_minutes": avg_minutes
    }
durations = [10, 5, 12, 3, 7, 9]

calculate_sum(durations)
print(f"Total rides: {calculate_sum(durations)['total_rides']} rides \n")
print(f"Total minutes: {calculate_sum(durations)['total_minutes']} minutes \n")
print(f"Average minutes: {calculate_sum(durations)['average_minutes']} minutes \n")