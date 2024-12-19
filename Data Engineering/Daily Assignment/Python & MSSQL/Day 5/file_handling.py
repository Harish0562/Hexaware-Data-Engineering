# 1. Text Files
# Writing to a text file
with open("example.txt", "w") as file:
    file.write("Hello, this is a text file.\n")
    file.write("Text files are human-readable.\n")

# Reading from a text file
with open("example.txt", "r") as file:
    content = file.read()
    print("Content of text file:\n", content)


# 2. Binary Files
# Writing binary data to a file
data = bytes([120, 3, 255, 0, 100])  # Sample binary data
with open("example.bin", "wb") as file:
    file.write(data)

# Reading binary data from a file
with open("example.bin", "rb") as file:
    binary_content = file.read()
    print("Content of binary file:", binary_content)
