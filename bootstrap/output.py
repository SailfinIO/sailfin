name = "Sail"
age = 25  # Mutable variable
def increment():
    global age
    age = (age + 1)
increment()
print(f"Age is now {age}")
