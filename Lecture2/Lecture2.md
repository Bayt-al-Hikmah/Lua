## Objectives
- Working with String, Tables (Arrays and Hashes)
- Comparison and Logical Operators
- Conditional Statements
- Working with Loops
## Working with String and Tables
### Strings
We use strings to store text values like names, messages, or any kind of written data. Strings are created by wrapping text in either double quotes (`"`) or single quotes (`'`):
```
name = "Alice"
greeting = 'Hello, world!'
```
we can create multiple line string using `[[]]`
```
text = [[Hello, 
this is a string]]
```

Strings in Lua are immutable, meaning once created, they cannot be changed. However, Lua provides many built-in functions within the `string` library to work with and manipulate strings easily.
#### Accessing Characters in a String
In Lua, individual characters in a string are typically accessed using the `string.sub` function, which extracts a substring. Lua string indices start at **1**, so the first character is at position `1`, the second at `2`, and so on.

```
word = "Lua"
print(string.sub(word, 1, 1)) -- => "L"
print(string.sub(word, 2, 2)) -- => "u"
print(string.sub(word, 3, 3)) -- => "a"
```

If we try to access an index that’s out of bounds, `string.sub` will return an empty string for ranges outside the string's length:
```
print(string.sub(word, 10, 10)) -- => ""
```
#### Negative Indexing
Lua's `string.sub` also supports negative numbers to count from the end of the string. -1 refers to the last character, -2 to the second to last, and so on:
```
word = "Programming"
print(string.sub(word, -1, -1)) -- => "g" (last character)
print(string.sub(word, -2, -2)) -- => "n"
```
#### Accessing Substrings
We can get more than one character using `string.sub` by providing a starting and ending index:
```
word = "Programming"
print(string.sub(word, 1, 5)) -- => "Progr" (from index 1 to 5)
```
To extract a substring by providing a starting index and a length, you can calculate the end index:
```
print(string.sub(word, 1, 1 + 5 - 1)) -- => "Progr" (start at 1, take 5 chars)
```
#### String Functions

##### `string.len(s)`  
Returns the number of characters (bytes) in the string:

```
name = "Alice"
print(string.len(name)) -- => 5
```
we can also get number of character of sting by using `#`
```
name = "Alice"
print(#name) -- => 5
```
##### `string.upper(s)` and `string.lower(s)  `
Convert a string to all **uppercase** or **lowercase**:
```
print(string.upper("hello")) -- => "HELLO"
print(string.lower("WORLD")) -- => "world"
```
##### `string.gsub(s, pattern, replacement)`  
Replaces parts of a string. The `pattern` argument uses Lua's pattern matching syntax, which is similar to regular expressions but not identical.
```
text = "I like Java"
print(string.gsub(text, "Java", "Lua")) -- => "I like Lua"
```
##### `string.find(s, substring)`  
Checks if a string **contains** a certain substring. It returns the start and end indices of the match if found, otherwise `nil`.
```
sentence = "Lua is fun"
print(string.find(sentence, "fun")) -- => (number)
print(string.find(sentence, "boring")) -- => nil
```
##### String Concatenation (`..`)
Adds two strings together using the `..` operator:
```
greeting = "Hello, " .. "Alice"
print(greeting) -- => "Hello, Alice"
```
You can also build strings using variable values:
```
name = "Bob"
print("Hello, " .. name) -- => "Hello, Bob"
```

### Tables 
In Lua, tables are the primary data structure used to store both ordered collections (like arrays) and key-value pairs (like hashes or dictionaries). Tables are written with curly braces `{}`, and values are separated by commas.
#### Arrays 
We use tables as arrays to store ordered collections of values. These values can be of the same type or different types: strings, numbers, booleans, and even other tables.
```
colors = {"red", "green", "blue"}
numbers = {1, 2, 3, 4, 5}
mixed = {"hello", 42, true}
```

#### Accessing Elements in an Array  
We access array elements using index numbers. In standard Lua practice, arrays are 1-indexed, meaning the first element is at position `1`:
```
colors = {"red", "green", "blue"}
print(colors[1]) -- => "red"
print(colors[2]) -- => "green"
print(colors[3]) -- => "blue"
```
If we try to access an index that doesn’t exist, Lua returns `nil`:
```
print(colors[10]) -- => nil
```
#### Array (Table) Functions
Lua's `table` library provides functions for common array operations.
##### `#table`
Returns the number of elements in the array-like part of the table (up to the first `nil` value):
```
colors = {"red", "green", "blue"}
print(#colors) -- => 3
```
##### `table.insert(table, pos, value)`
Inserts an element at a specific position. If `pos` is omitted, it defaults to the end.
```
colors = {"red", "green", "blue"}
table.insert(colors, 1, "black") -- Inserts at the start
-- colors is now {"black", "red", "green", "blue"}
```
##### `table.insert(table, value)`
Adds an element to the end:
```
colors = {"red", "green", "blue"}
table.insert(colors, "yellow")
-- colors is now {"red", "green", "blue", "yellow"}
```
##### `table.remove(table, pos)`
Removes and returns the element at the given `pos`. If `pos` is omitted, it removes the last element.
```
colors = {"red", "green", "blue"}
local first_color = table.remove(colors, 1) -- Removes first element
print(first_color) -- => "red"
```
##### `table.remove(table)`
Removes and returns the last element:
```
colors = {"red", "green", "blue"}
local last_color = table.remove(colors) -- Removes last element
print(last_color) -- => "blue"
```
##### `table.sort(table, compare_function)`
Sorts the array in place. You can provide an optional `compare_function` for custom sorting.

```
numbers = {3, 1, 5, 2}
table.sort(numbers) -- Sorts in ascending order by default for numbers
-- numbers is now {1, 2, 3, 5}

-- Custom sort (e.g., descending)
table.sort(numbers, function(a, b) return a > b end)
-- numbers is now {5, 3, 2, 1}
```
##### `table.concat(table, separator)`
Combines array elements into a single string.
```
colors = {"red", "green", "blue"}
print(table.concat(colors, ", ")) -- => "red, green, blue"
```
#### Hashes 
We use tables as hashes (also called associative arrays or dictionaries) to store **key-value pairs**. Each key is linked to a specific value, making tables perfect for representing things like settings, user profiles, and objects with properties. Tables as hashes are written using curly braces `{}` and can use strings, numbers, or even other Lua values (except `nil` or `NaN`) as keys. String keys are often written without quotes if they are valid Lua identifiers:

```
person = {
    name = "Alice",
    age = 30
}
-- Or using string literals for keys (required if key has spaces or special chars):
config = {
    ["file path"] = "/usr/local/data",
    ["version"] = 1.0
}
```
#### Accessing Hash Values
To access a value, use the corresponding key with dot notation or square bracket notation:
```
person = {
    name = "Alice",
    age = 30
}
print(person.name) -- => "Alice"
print(person["age"]) -- => 30
```
If the key doesn’t exist, Lua returns `nil`:
```
print(person.email) -- => nil
```
#### Adding or Updating Entries
You can add new key-value pairs or update existing ones by assigning a value to a key:
```
person = {
    name = "Alice",
    age = 30
}
person.email = "alice@example.com"
person.age = 31
```
#### Hash Functions
Lua provides ways to iterate over table keys and values, but some "hash methods" from other languages need to be implemented manually.
##### Removing a key-value pair
Set the value associated with the key to `nil`:
```
person = {
    name = "Alice",
    age = 30,
    email = "alice@example.com"
}
person.email = nil
-- email key is now removed
```
##### Checking if a key exists
Check if the value associated with the key is not `nil`:
```
person = {
    name = "Alice",
    age = 30,
    email = "alice@example.com"
}
print(person.name ~= nil) -- => true
print(person.city ~= nil) -- => false
```
## Comparison and Logical Operators
### Comparison Operators
Comparison operators help us compare values or variables with each other and create conditions based on the results. These comparisons always return a boolean value either `true` or `false`. Lua provides us with the following comparison operators:
- `>` (**Greater than**): Checks if the first operand is greater than the second.
```
print(5 > 4)  -- => true
print(3 > 10) -- => false
```
- `<` (**Less than**): Checks if the first operand is less than the second.
```
print(4 < 5)  -- => true
print(7 < 3)  -- => false
```
- `==` (**Equal to**): Checks if both operands are equal.
```
print(4 == 4)       -- => true
print("hi" == "hello") -- => false
```
- `~=` (**Not equal to**): Checks if the operands are not equal.
```
print(1 ~= 0) -- => true
print(5 ~= 5) -- => false
```
- `>=` (**Greater than or equal to**): Checks if the first operand is greater than or equal to the second.
```
print(2 >= 2) -- => true
print(3 >= 5) -- => false
```
- `<=` (**Less than or equal to**): Checks if the first operand is less than or equal to the second.
```
print(2 <= 3) -- => true
print(4 <= 1) -- => false
```

### Logical Operators in Lua
Lua provides logical operators to combine multiple conditions and build more complex expressions. The result of a logical operation is always a boolean value (`true` or `false`) in a boolean context, though `and` and `or` return one of their operands.
#### `or` (OR)
- Returns `true` if **at least one** of the conditions is true.
- Returns `false` only if **all** the conditions are false.
```
print(true or false) -- => true
print(false or false) -- => false
```
#### `and` (AND)
- Returns `true` only if **all** the conditions are true.
- Returns `false` if **any** of the conditions is false.
```
print(true and true)  -- => true
print(true and false) -- => false
```
#### `not` (NOT)
- Reverses the logical state of the condition.
- If the condition is `true`, `not` makes it `false`, and vice versa.
```
print(not true)  -- => false
print(not false) -- => true
```
#### Truth Table for Logical Operators:

| **A** | **B** | **A and B** | **A or B** | **not A** |
| ----- | ----- | ----------- | ---------- | --------- |
| true  | true  | true        | true       | false     |
| true  | false | false       | true       | false     |
| false | true  | false       | true       | true      |
| false | false | false       | false      | true      |

## Conditional Statements
Conditional statements are fundamental programming constructs that enable our code to make decisions and execute different actions based on specific conditions. They control program flow by evaluating whether certain criteria are met, allowing for dynamic behavior that responds to different situations, inputs, or values.
### `if`, `else`, and `elseif` Statement
#### Single Condition with `if`

When we need to execute code only when a condition is true:
```
if condition then
    -- Code executes only if condition evaluates to true
end
```
**Example:**
```
age = 18

if age >= 18 then
    print("You are an adult.")
end
-- Output when age is 18: "You are an adult."
```
#### Alternative Path with `if-else`
When we want to handle both true and false cases differently:
```
if condition then
    -- Code for true case
else
    -- Code for false case
end
```
**Example:**
```
is_raining = false

if is_raining then
    print("Bring an umbrella.")
else
    print("No umbrella needed today.")
end
-- Output: "No umbrella needed today."
```
#### Multiple Conditions with `elseif`
When we need to check several possible conditions in sequence:

```
if condition1 then
    -- First case
elseif condition2 then
    -- Second case
else
    -- Default case
end
```
**Example:**
```
score = 85
if score >= 90 then
    print("Excellent performance")
elseif score >= 80 then
    print("Good job")
else
    print("Room for improvement")
end
-- Output: "Good job"
```
### Simulating a `case` Statement
Lua does not have a direct `case` or `switch` statement. It is typically implemented using a series of `if-elseif-else` statements or by using a table where keys map to functions or values.

#### Using `if-elseif-else`
```
day = "Monday"

if day == "Monday" then
    print("Weekday 1")
elseif day == "Tuesday" then
    print("Weekday 2")
elseif day == "Saturday" or day == "Sunday" then
    print("Weekend!")
else
    print("Unknown day")
end
```
#### Using a Table 
```
local actions = {
    ["Monday"] = function() print("Weekday 1") end,
    ["Tuesday"] = function() print("Weekday 2") end,
    ["Saturday"] = function() print("Weekend!") end,
    ["Sunday"] = function() print("Weekend!") end
}

day = "Monday"
if actions[day] then
    actions[day]()
else
    print("Unknown day")
end
```
## Loops
Loops help us repeat code multiple times without rewriting it. They’re essential when we want to perform the same task on a group of values, or when we don’t know in advance how many times we need to run some code. Lua gives us several types of loops, and each is useful in different situations.
### `while` Loop
A `while` loop keeps running as long as a condition is true.
```
count = 1
while count <= 5 do
    print("Count is " .. count)
    count = count + 1
end
```
**Output:**
```
Count is 1
Count is 2
Count is 3
Count is 4
Count is 5
```
If the condition is `false` to begin with, the code inside won’t run at all.
### `repeat-until` Loop
Lua's `repeat-until` loop is similar to an `until` loop in other languages: it runs the loop until the condition becomes true. The code inside the loop is always executed at least once.
```
count = 1
repeat
    print("Count is " .. count)
    count = count + 1
until count > 5
```
This produces the same output as the `while` loop example.
### `for` Loop
A `for` loop is used to iterate a specific number of times (numeric `for`) or to iterate over a collection (generic `for`).
#### Numeric `for` loop
This loop goes through a range of numbers:
```
for i = 1, 3 do
    print("Iteration " .. i)
end
```
Output:
```
Iteration 1
Iteration 2
Iteration 3
```
#### Generic `for` loop 
This is the most common way to loop through tables (arrays or hashes) in Lua.
- **`ipairs` for sequential arrays:** Iterates over the integer keys from 1 up to the first `nil` value.
```
colors = {"red", "green", "blue"}

for index, color in ipairs(colors) do
    print("Color at index " .. index .. ": " .. color)
end
```
- **`pairs` for any table (including hashes):** Iterates over all key-value pairs in a table (order is not guaranteed).
```
person = { name = "Alice", age = 30 }

for key, value in pairs(person) do
    print(key .. ": " .. value)
end
```
### Infinite Loop with `while true` and `break`
An infinite loop can be created with `while true do`. We explicitly stop it with `break` when a certain condition is met.
```
counter = 1
while true do
    print("Looping: " .. counter)
    counter = counter + 1
    if counter > 3 then
        break -- Exit the loop
    end
end
```
### `break` Keyword
- `break`: Stops the loop entirely. It immediately exits the innermost loop.

**Example with `break`**
```
for i = 1, 5 do
    if i == 4 then
        break -- Stop the loop when i is 4
    end
    print(i)
end
-- Output:
-- 1
-- 2
-- 3
```
### Simulating `continue` (or `next`)
Lua does not have a `continue` (or `next`) keyword like some other languages. To skip the rest of the current iteration and jump to the next one, you typically use `if-then` statements to wrap the code you want to execute conditionally.
```
for i = 1, 5 do
    if i == 3 then
        -- Skip the rest of this iteration
    else
        print(i)
    end
end
-- Output:
-- 1
-- 2
-- 4
-- 5
```
Alternatively, you can use `goto` (though often avoided for simpler cases):
```
for i = 1, 5 do
    if i == 3 then
        goto next_iteration
    end
    print(i)
    ::next_iteration:: -- Label to jump to
end
```
## Tasks
### Task 1
- Create string variable with name `word` and value `"Developer"`
    - Print the first and last characters using indexing`
    - Convert to uppercase and print`
- Create string variable named `phrase` with this text `"I love Python"`
    - Replace "Python" with "Lua" and print the result
- Create string variable named `sentence` with this text `"Learning Lua is fun"`
    - Print true if "Lua" is in the sentence`
    - Print the number of characters in the sentence
### Task 2
- Create an array of colors: `["red", "green", "blue"]`
    - print last and first element
    - Add "yellow" to the end of the array
    - Insert "black" at the beginning
    - Remove and print the last element
    - Check if "green" exists in the array
- Sort the array `[5, 3, 8, 1]` in ascending order
### Task 3
- Create a hash representing a person with name, age, and city
    - Print the name
    - Add a new key-value pair for occupation
    - Print all the keys of the hash
    - Check if the hash contains a key `age`
    - Merge with another hash `{ hobbies: ["reading", "coding"] }`
    - Delete the city information from the hash

### Task 4
- Write an if-else statement that checks if a number is even or odd
- Write a program that recommends clothing based on temperature:
    - Above 30°C: "Wear shorts"
    - 20-30°C: "T-shirt weather"
    - Below 20°C: "Bring a jacket"

### Task 5
- Create a program that asks the user to enter a number and calculates its factorial using a `while` loop.
- Ask the user for two numbers and display all prime numbers between them using a `for` loop.
- Ask the user to enter a number `n`, and use an `repeat-until` loop to print all even numbers from 0 up to `n`.
