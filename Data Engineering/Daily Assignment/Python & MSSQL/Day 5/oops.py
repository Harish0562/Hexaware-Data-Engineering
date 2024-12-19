# 1. OOP Concepts
#Class and Object
class Car:
    def __init__(self, brand, model):
        self.brand = brand
        self.model = model

car1 = Car("Toyota", "Corolla")
print(car1.brand)


# Inheritance
class Animal:
    def sound(self):
        return "Some sound"

class Dog(Animal):
    def sound(self):
        return "Bark"


# 2. Constructor, Inheritance, Polymorphism, Method Overriding
class Animal:
    def __init__(self, name):
        self.name = name

    def sound(self):
        return "Some sound"

class Dog(Animal):
    def sound(self):
        return "Bark"
