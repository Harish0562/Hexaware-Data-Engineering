import csv

# Data to write to CSV
data = [
    ['Name', 'Age', 'City'],
    ['Alice', 28, 'New York'],
    ['Bob', 25, 'Los Angeles'],
    ['Charlie', 30, 'Chicago']
]

# Writing data to CSV file
with open('output.csv', mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerows(data)

print("Data written to output.csv")
