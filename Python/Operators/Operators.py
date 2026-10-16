# Python has different operators that can be used for your code. Each has varying uses in different situations. 

# They include:
# Arithmetic operators
# Assignment operator
# Comparison operators
# Logical operators
# Identity operators
# Membership operators
# Bitwise operators

# Each of these operators accepts specific data types when they are used. The relevant data types are: 

        # 1. Numbers (int, float, complex)
                # Integers - Simple numbers like 1, 84, and 328903759082. 
                # Floats - Decimal numbers. 4.5, 78.2, 1094.43. 
                # Complex - Numbers with imaginary units. In Python, these include any range of numbers, with either an "l" or "j" for the imaginary unit.
        # 2. Strings - Any range of characters contained within either "" or ''. Letters, numbers, symbols, etc. As long as it's in quotes, it's a string.\
        # 3. Lists - 
        # 4. Tuples - 
        # 5. Dictionaries - 
        # 6. Sets - 
        # 7. Booleans - 


# **** A-R-I-T-H-M-E-T-I-C - O-P-E-R-A-T-O-R-S ****
# --------------------------------------------
# Artithmetic operators are the fundamental math that we learn in grade school. Addition, subtraction, multiplication, division, and a few others called modulus, exponentiation, and floor division. 

    # [[[*** A D D I T I O N (+)***]]]
    # -------------------------------------------------------------------------------------------------------------------------------------------------------------
    # Addition is represented by "+" and simply adds matching data types together. 
    # It does have limitations though. Different data types cannot be added together. Your computer will throw and error. 

        # ** INTEGERS **
        # -------------------------------------------------------------------------------------------
2 + 3 # Answer will be 5. The computer is reading the numbers as integers (actual numbers) versus other data types. 

        # ** FLOATING POINT NUMBERS **
        # --------------------------------------------------------------------------------------------------------------------------------------------------

2.5 + 3 # Answer will be 5.5. The computer is reading the numbers as a float (decimal numbers) and integer.

        # Floats and integers can be combined in all standard arithmetic operators.
         
        # ** STRINGS **
        # ------------
        # when working with strings, the + operator works as a concatenator, meaning it combines any two strings together! 

print("Hello" + " World") # You'll need to use the "print" function in order to actually see the results. 

        # ** COMPLEX NUMBERS **
        # ------------
        
        # Complex numbers do have a few limitations. If you try and add complex numbers with different imaginary components you'll get a different output. 

        # Complex numbers are technically float numbers, and have 2 integers: a "real" one (represented as a number) and an "imaginary" one (represented by a letter). 

(5+3j) + (1+2j) # This equation gives us (6+5j) as a result. Notice that since the plain integers and complex numbers can't be added together so the two parenthesis are added together instead. 

# There are limitations with using different imaginary components in complex numbers though.

(3+5j) + (7 +2) # This simply adds the all the numbers together and carries the imaginary number ("j") over. 

        # ** LISTS ** 
        # ------------
        # Lists an be added togther too!
[1, 2, 3] + [4, 5, 6] # For lists, the + maintaines the data format (a list) and simply merges them into one. So this would give us [1,2,3,4,5,6]. 

        # ** TUPLES **
        # ------------
        # Tuples can be added together too! Remember, tuples are essentially lists that are "immutable" (they can't change once they've been set). 
(1, 2, 3) + (4, 5, 6) # The same principle that applies to lists applies to tuples as well. This will combine the two and give us (1,2,3, 4, 5, 6). 

     # [[[*** S U B T R A C T I O N (-)***]]]
     # --------------------------------------------------------------------------------------------------------------------------------------------------------
        # ** INTEGERS **
        # -------------------------------------------------------------------------------------------
        # Super simple. Subtracting numbers. Nothing else to it. 
2 - 3 # Answer will be 5. The computer is reading the numbers as integers (actual numbers) versus other data types. 

        # ** FLOATING POINT NUMBERS **
        # --------------------------------------------------------------------------------------------------------------------------------------------------
        # Floating numbers (i.e numbers with decimals) can be added together, and can also work with regular integer numbers, like the example below. 

2.5 - 3 # Answer will be 0.5. 

        # ** COMPLEX NUMBERS **
        # ------------
        # The - operator can be used on complex numbers as well.The same rules apply when using subraction.  

        # There are limitations with complex numbers though. If you try and add complex numbers with imaginary components (letters), you'll get a different output. 

        # Additionally, only 2 imaginary letters accepted (at least with python) as imaginary components, j and l. 

        # For example, lets look at the below equation. 

(5+3j) - (1+2j) # This equation gives us (6+5j) as a result. Notice that since the plain integers and complex numbers can't be added together, the two parenthesis are added together. 

        # There are limitations with using different imaginary components in complex numbers though.

(3+5j) - (7 +2) # This gives us a syntax error "invalid decimal literal", because the two letters don't match up. 

# Why aren't lists and tuples able to be subtracted? Simply put, subtraction is not a valid operation for that data type. 

# [[[*** M U L T I P L I C A T I O N  (*) ***]]]
     # --------------------------------------------------------------------------------------------------------------------------------------------------------
      # Multiplication is represented with a * symbol (SHIFT + 8) and works on several types of data!

        # ** INTEGERS **
        # -------------------------------------------------------------------------------------------
        # Again, super simple. Basic math. 
2 * 3 # Answer will be 6. 

        # ** FLOATING POINT NUMBERS **
        # --------------------------------------------------------------------------------------------------------------------------------------------------
        # Floating numbers (i.e numbers with decimals) can be added together, and can also work with regular integer numbers, like the example below. 

2.5 * 3 # Answer will be 7.5. Since we're multiplying 2.5 * 3, it's equal to 2.5 + 2.5 + 2.5, so 7, with a 0.5 leftover. Keep this in mind with floats.

        # ** STRINGS **
        # ------------
        # Multiplication can be used on strings as well, but acts as a sort of loop function that runs the string the number of times indicated. 

("Hello World ") * 2 # This gives us "Hello World Hello World" as a result. 
# The computer will copy the string as many times as indicated, but throws and error when you add a "print" statement into the mix.

        # ** COMPLEX NUMBERS **
        # ------------
        # The - operator can be used on complex numbers as well.The same rules apply when using subraction.  

        # There are limitations with complex numbers though. If you try and add complex numbers with imaginary components (letters), you'll get a different output. 

        # Additionally, only 2 imaginary letters accepted (at least with python) as imaginary components, j and l. 

        # For example, lets look at the below equation. 

(5+3j) * (1+2j) # This equation gives us (-1+13j) as a result. Notice that since the plain integers and complex numbers can't be added together, the two parenthesis are added together. 

        # There are limitations with using different imaginary components in complex numbers though.

(3+5j) * (7 +2) # This gives us a syntax error "invalid decimal literal", because the two letters don't match up. 

# Arithmetic operators also function on floating and complex numbers, but naturally there are limitations. 

# ** MULTI-ARITHMETIC OPERATIONS ***
# ------------
# In regards to more complex math, say an equation that uses multiple arithmetic operators
# the computer will follow each arithmetic operator in the order of PEMDAS (Parenthesis, Exponents, Multiplication, Division (which operate on the same level), and Addition, Subtraction (same level like Mult & Division)). 

(((1 + 3) * (9 - 2) / 2) *2) # This will output 28. 1+3=4, then 9-2=7. 7*4=28, 28/2=14, then finally it's 14*2=28. 
# It's worth noting that if you add multiple arithmetic symbols, the computer interprets it as raising a number to the Nth power.
# For example, adding one extra multiplier between 1-3 and 9-2, you're turning the second number into the Nth power. 

(((1 + 3) ** (9 - 2) / 2) *2) # This will output 16384

# So 4 to the 7th power (4 x 4 x 4 x 4 x 4 x 4 x 4)= 16384. Finishing the rest of the calculation via PEMDAS, divide 16384 by 2=1892, then muliplied by 2 again is 16384.  

# **** A-S-S-I-G-N-M-E-N-T - O-P-E-R-A-T-O-R-S ****
# --------------------------------------------------------------------------------------------------------------------------------------------------------------
# **** COMPARISON OPERATORS ****
# **** LOGICAL OPERATORS ****
# **** IDENTITY OPERATORS ****
# **** MEMBERSHIP OPERATORS ****
# **** BITWISE OPERATORS ****