# 1. Map Function
numbers = [1, 2, 3, 4]
squared = list(map(lambda x: x ** 2, numbers))
print(squared)


# 2. String, Number, Date and Time Functions
# String function
text = "hello"
print(text.upper())

# Number function
abs_value = abs(-5)
print(abs_value)

# Date and time
import datetime
print(datetime.datetime.now())


# 3. Functions and Lambda Expressions
def add(a, b):
    return a + b
print(add(5, 3))

# Lambda
multiply = lambda x, y: x * y
print(multiply(3, 4))
