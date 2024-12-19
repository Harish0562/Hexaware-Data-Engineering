x=1
# 1.Control Structures
# If Statement
if x > 0:
    print("Positive number")

# If-else Statement
if x % 2 == 0:
    print("Even")
else:
    print("Odd")

# If-elif-else Statement
if x > 0:
    print("Positive")
elif x < 0:
    print("Negative")
else:
    print("Zero")

# For Loop
for i in range(5):
    print(i)

# While Loop
count = 0
while count < 5:
    print(count)
    count += 1

# Break, Continue & Pass
for i in range(5):
    if i == 3:
        break
    print(i)

# 2. Input and Output
name = input("Enter your name: ")
print("Hello", name)

# 3. Lists
my_list = [1, 2, 3, 4]
my_list.append(5)
print(my_list)

# 4. Dictionaries
my_dict = {'name': 'John', 'age': 30}
print(my_dict['name'])


# 5. Sets
my_set = {1, 2, 3}
my_set.add(4)
print(my_set)




