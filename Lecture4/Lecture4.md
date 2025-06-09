## Objectives
- Object-Oriented Programming (OOP)
- Error Handling
## Object-Oriented Programming
### Introduction
Object-Oriented Programming (OOP) is a programming paradigm that organizes software around "objects" that contain both data (attributes) and code (methods) that operate on that data.
- **Objects**: Represent real-world entities like a car, a person, or a bank account. Each object has unique characteristics (attributes) and behaviors (methods).
- **Classes**: Blueprints or templates for creating objects. A class defines the attributes and methods that objects of that class will have.

**Core Principles of OOP:**
- **Encapsulation**: Combines data and the functions that operate on that data within a single unit. This helps to keep data safe from outside interference and misuse, and clearly defines the interface for interacting with the object.
- **Abstraction**: Allows programmers to hide all but the relevant data about an object, reducing complexity and increasing efficiency. It focuses on what an object _does_ rather than how it _does_ it.
- **Inheritance**: Facilitates the creation of new classes based on existing ones. It promotes code reusability by allowing shared behaviors to be defined once and inherited by child classes.
- **Polymorphism**: Enables different classes to be treated through the same interface, often by overriding methods or implementing the same methods in different ways. This allows for flexible and extensible code.
### Creating a Class
In Lua, there isn't a direct `class` keyword like in some other languages. Instead, OOP is typically implemented using tables and metatables. A common pattern involves creating a table to serve as the class, which holds shared methods, and then using a constructor function to create new instances (objects) as tables, associating them with the class methods through their metatable.  
Attributes are simply keys within the object's table. Methods are functions defined within the class table.  
Let's look at an example:

```
Person = {}
Person.__index = Person 

function Person:new(name, age)
    local o = {} 
    setmetatable(o, self)
    o.name = name 
    o.age = age
    return o
end

function Person:greet()
    print("Hello, my name is " .. self.name .. "!")
end

local person = Person:new("Ali", 20)
person:greet() 
```

In this example:
- **`Person = {}`**: We begin by creating a simple table named `Person`. This table will serve as our "class" – it holds the blueprint for `Person` objects, specifically their shared methods.
- **`Person.__index = Person`**: This line is a key part of how Lua achieves method lookup and effectively allows for single inheritance. `__index` is a special field (a "metamethod") in a metatable. When you try to access a field (like a method) on a table, and that field _doesn't exist_ in the table itself, Lua will then check its metatable's `__index` field. If `__index` is a table (like `Person` itself in this case), Lua will look for the missing field in _that_ table. This means if `person.greet` isn't found in the `person` instance table, Lua will look for it in the `Person` class table (because `Person` is set as the `__index` for `person`'s metatable).
- **`function Person:new(name, age)`**: This is our constructor function. The colon syntax (`:`) is syntactic sugar for `function Person.new(self, name, age)`. When `Person:new(...)` is called, `self` automatically refers to the `Person` table (our class table).
    - **`local o = {}`**: Inside `new`, we create a brand new, empty table `o`. This `o` is going to be our actual object instance. At this point, `o` has no methods or attributes of its own yet, except for the ones we're about to add.
    - `setmetatable(o, self)`: This is the core of linking the instance to the class.
        - The `setmetatable()` function takes two arguments: the table whose metatable you want to set (`o`, our new instance) and the metatable itself (`self`, which is `Person` in this context).
        - By setting `o`'s metatable to `Person`, we are telling Lua: "If you try to find a key (like a method or attribute) in `o` and it's not directly there, then check `Person`'s `__index` value for it." Since `Person.__index` is set to `Person` itself, this effectively means Lua will look for missing methods in the `Person` class table.
    - **`o.name = name`** and **`o.age = age`**: These lines directly assign the provided `name` and `age` values as attributes (fields) within the `o` instance table. These attributes are unique to each `Person` object.
    - **`return o`**: The constructor returns the newly created and initialized object instance.
- **`function Person:greet()`**: This defines the `greet` method. Because it's defined within the `Person` table and uses the colon syntax, it will be shared by all instances created from the `Person` class. When `person:greet()` is called, `self` inside this function will refer to the `person` object instance.
- **`local person = Person:new("Ali", 20)`**: This line creates an actual `Person` object. The `new` constructor runs, creating a table `person`, setting its metatable to `Person`, and initializing its `name` and `age`.
- **`person:greet()`**: When this method call occurs, Lua first looks for a `greet` field directly in the `person` table. It doesn't find one. So, it consults `person`'s metatable (which is `Person`). It then looks at the `__index` field of `Person`, which points back to `Person` itself. Finally, it finds `Person.greet`, and executes it, with `self` being the `person` object
### Constructor
A constructor is a special method that runs automatically every time we create a new instance of a class. We use constructors primarily to initialize an object's attributes with starting values.  
In Lua, the constructor is typically a function (often named `new`) defined within the class table. This function is responsible for creating and returning a new instance of the class, setting up its initial state.
```
Person = {}
Person.__index = Person

-- Constructor function
function Person:new(name, age)
    local o = {}
    setmetatable(o, self)
    o.name = name
    o.age = age
    return o
end
```
When `Person:new("Alice", 30)` is called:
1. An empty table `o` is created.
2. The metatable of `o` is set to `Person`.
3. The `name` and `age` attributes of `o` are initialized with "Alice" and 30, respectively.
4. The initialized `o` table is returned.
### Getter and Setter
In Lua, table fields (attributes) are public by default. This means you can directly access and modify them from outside the table.

```
local person = Person:new("Alice", 30)
print(person.name) -- Direct access to attribute
person.name = "Bob" -- Direct modification of attribute
print(person.name)
```
While direct access is common and often acceptable in Lua, for more controlled access or to perform validation during attribute access/modification, you can define getter and setter methods. These are regular functions that encapsulate the logic for reading (`get_`) and writing (`set_`) attribute values.
```
Person = {}
Person.__index = Person

function Person:new(name, age)
    local o = {}
    setmetatable(o, self)
    o._name = name -- Conventionally, use an underscore for "private" attributes
    o._age = age
    return o
end

function Person:getName()
    return self._name
end

function Person:setName(newName)
    self._name = newName
end

function Person:getAge()
    return self._age
end

local person = Person:new("Alice", 30)

print(person:getName()) 
person:setName("Bob")   
print(person:getName())
print(person:getAge())
```
In this improved example:
- We've used `_name` and `_age` as a convention to suggest that these are internal attributes that should ideally be accessed via methods. This is a common pattern in Lua for "pseudo-private" fields, as true private access isn't built-in.
- `getName` and `getAge` are getter methods, providing read access.
- `setName` is a setter method, providing write access. If you wanted an attribute to be read-only, you would simply omit its setter method.
### Class Methods and Attributes (Static Members)
When designing classes, we sometimes need functionality or data that is associated with the class itself, rather than with individual instances. These are often referred to as static members in other languages.
In Lua, "class variables" or "static attributes" are simply fields directly defined in the class table. "Class methods" or "static methods" are functions also defined in the class table, and they are typically called directly on the class table without creating an instance. They don't operate on `self` in the same way instance methods do.
```
MathUtils = {}

)
MathUtils.PI = 3.14159
function MathUtils.circle_area(radius)
    return MathUtils.PI * (radius^2)
end

print(MathUtils.PI)           
print(MathUtils.circle_area(5))
```
Here:
- `MathUtils.PI` is a class attribute. It belongs to the `MathUtils` table itself.
- `MathUtils.circle_area` is a class method. It's called directly on `MathUtils` and doesn't implicitly receive an instance (`self`) as its first argument.
### Inheritance
To understand **inheritance**, let’s imagine we’re building a simple program to represent a **pet store**. In our store, we want to include different animals, let’s say **cats** and **dogs**.  
At first, we might think of creating two separate classes: `Cat` and `Dog`. But very quickly, we’ll notice that both animals share some common characteristics they both have names, ages, and they both can eat and sleep.  
Instead of writing the same code twice, we can create a **parent class** called `Pet` that contains all the shared attributes and behaviors. Then, `Cat` and `Dog` can **inherit** from `Pet`, gaining all of its features, and we can add species-specific behavior to each one.  
In Lua, inheritance is typically implemented by setting the `__index` metatable of the child class to the parent class. This creates a lookup chain for methods and attributes.
```
Pet = {}
Pet.__index = Pet

function Pet:new(name, age)
    local o = {
        name = name,
        age = age
    }
    setmetatable(o, self)
    return o
end

function Pet:eat()
    print(self.name .. " is eating.")
end

function Pet:sleep()
    print(self.name .. " is sleeping.")
end

Dog = {}
setmetatable(Dog, {__index = Pet}) 
Dog.__index = Dog   

function Dog:new(name, age)
    local o = Pet.new(self, name, age)
    setmetatable(o, self) 
    return o
end

function Dog:speak()
    print(self.name .. " says Woof!")
end

-- Child Class: Cat
Cat = {}
setmetatable(Cat, {__index = Pet})
Cat.__index = Cat

function Cat:new(name, age)
    local o = Pet.new(self, name, age)
    setmetatable(o, self)
    return o
end

function Cat:speak()
    print(self.name .. " says Meow!")
end

local dog = Dog:new("Buddy", 3)
local cat = Cat:new("Whiskers", 2)

dog:eat()
dog:speak()

cat:sleep()
cat:speak()
```

Here's how inheritance works in this Lua example:
- `setmetatable(Dog, {__index = Pet})`: This is the crucial line for class-level inheritance. It means that if a method or attribute is not found directly in the `Dog` class table, Lua will look it up in the `Pet` class table. This allows `Dog:new` to call `Pet.new(self, name, age)`.
- `Dog.__index = Dog`: This ensures that when you call a method on a `Dog` _instance_ (e.g., `dog:speak()`), Lua first looks for the method in the `dog` instance table, then in the `Dog` class table (via `dog`'s metatable), and if not found there, it then follows the `__index` chain from `Dog` to `Pet`.
- In the child class `new` constructor (e.g., `Dog:new`), we explicitly call the parent's constructor (`Pet.new(self, name, age)`). We pass `self` (which is the `Dog` class table when `Dog:new` is called) to `Pet.new` so that `Pet.new` correctly sets the metatable of the new object to `Dog` (or whatever `self` is).

Sometimes, we want the child class to **override** a method from the parent class but still keep part of the original behavior. In such cases, we can explicitly call the parent class’s version of the method.

```
Pet = {}
Pet.__index = Pet

function Pet:new(name, age)
    local o = {
        name = name,
        age = age
    }
    setmetatable(o, self)
    return o
end

function Pet:speak()
    print(self.name .. " makes a sound.")
end

function Pet:info()
    print(self.name .. " is " .. self.age .. " years old.")
end


Dog = {}
setmetatable(Dog, {__index = Pet})
Dog.__index = Dog

function Dog:new(name, age)
    local o = Pet.new(self, name, age)
    setmetatable(o, self)
    return o
end

function Dog:speak()
    Pet.speak(self) -- Explicitly call the parent's speak method
    print(self.name .. " says Woof!")
end

Cat = {}
setmetatable(Cat, {__index = Pet})
Cat.__index = Cat

function Cat:new(name, age)
    local o = Pet.new(self, name, age)
    setmetatable(o, self)
    return o
end

function Cat:speak()
    Pet.speak(self) -- Explicitly call the parent's speak method
    print(self.name .. " says Meow!")
end

local dog = Dog:new("Rex", 4)
local cat = Cat:new("Luna", 2)

dog:speak()
cat:speak()
```
By calling `Pet.speak(self)` inside `Dog:speak()` and `Cat:speak()`, we execute the parent's `speak` logic before adding the specific behavior of the child class.
### Encapsulation
To understand encapsulation, let’s continue working with our pet store example. When building a class like `Pet`, we want to make sure that internal details like how the pet's data is stored or updated are protected from the outside world.
Encapsulation is all about controlling access to the data and behavior inside a class. In Lua, since tables are public by default, encapsulation is often achieved through conventions, local variables, and careful design of the class interface. True privacy (where data cannot be accessed at all from outside) is typically implemented using closures.  
Let's illustrate with conventions first:
```
Pet = {}
Pet.__index = Pet

function Pet:new(name, age)
    local o = {
        name = name,
        age = age
    }
    setmetatable(o, self)
    return o
end

function Pet:info()
    print(self.name .. " is " .. self.age .. " years old.")
    self:_check_health() -- Call the "private" method
end

function Pet:_check_health()
    print(self.name .. "'s health is good!")
end

local pet = Pet:new("Coco", 4)
pet:info()
```

In this example:
- `_check_health` is conventionally marked as "private" by prefixing it with an underscore. This is a common practice to signal that the method is intended for internal use only. However, Lua doesn't enforce this; you can still call `pet:_check_health()` from outside the class.

For stronger encapsulation, where attributes or methods are truly inaccessible from outside, you can use closures in the constructor:

```
Pet = {}

function Pet:new(name, age)
    local _name = name 
    local _age = age  

    local function _check_health() 
        print(_name .. "'s health is good!")
    end

    local o = {} 
    function o:getName()
        return _name
    end

    function o:setName(newName)
        _name = newName
    end

    function o:getAge()
        return _age
    end
    function o:info()
        print(_name .. " is " .. _age .. " years old.")
        _check_health() -- Can call the private method
    end
    
    setmetatable(o, self) -- Link to the class table for shared methods
    return o
end


Pet.__index = Pet 

local pet = Pet:new("Coco", 4)
pet:info()
-- print(pet._name) -- This won't work, _name is truly private
-- pet:_check_health() -- This won't work
print(pet:getName()) -- Access via public getter
```
In this stronger encapsulation example:
- `_name`, `_age`, and `_check_health` are local variables/functions within the `new` constructor. They are only accessible within the scope of that constructor and the functions defined within it (like `o:info`). This creates a closure where the public methods (`o:getName`, `o:info`) can access the private data/methods, but outside code cannot.
### Polymorphism
Polymorphism means “many forms.” In programming, it allows us to use the same method name to perform different behaviors depending on the object that’s calling it. This makes our code more flexible and easier to extend.  
Let’s go back to our pet store example. Suppose we want each pet to "speak." We can define a `speak` method in both the `Dog` and `Cat` classes. Even though the method name is the same, each class can implement it differently. So when we call `speak` on a dog, it might bark, and when we call it on a cat, it might meow.  
Thanks to polymorphism, we can treat different objects in a uniform way. We can loop through a list of pets and call `speak` on each one, without worrying about whether it’s a dog or a cat. Lua will automatically run the correct version of the method based on the object’s type and its metatable lookup chain.

```
Pet = {}
Pet.__index = Pet

function Pet:new(name)
    local o = {
        name = name
    }
    setmetatable(o, self)
    return o
end

Dog = {}
setmetatable(Dog, {__index = Pet})
Dog.__index = Dog

function Dog:new(name)
    local o = Pet.new(self, name)
    setmetatable(o, self)
    return o
end

function Dog:speak()
    print(self.name .. " says Woof!")
end

Cat = {}
setmetatable(Cat, {__index = Pet})
Cat.__index = Cat

function Cat:new(name)
    local o = Pet.new(self, name)
    setmetatable(o, self)
    return o
end

function Cat:speak()
    print(self.name .. " says Meow!")
end

local pets = {Dog:new("Rex"), Cat:new("Luna")}

for _, pet in ipairs(pets) do
    pet:speak()
end
```

When `pet:speak()` is called in the loop:
- If `pet` is a `Dog` instance, Lua looks up `speak` in the `dog` instance's metatable (which is `Dog`), finds `Dog:speak`, and executes it.
- If `pet` is a `Cat` instance, Lua looks up `speak` in the `cat` instance's metatable (which is `Cat`), finds `Cat:speak`, and executes it. This demonstrates how the same method call (`:speak()`) behaves differently based on the specific type of the object, which is the essence of polymorphism.

### Operator Overloading
Operator overloading is the act of overriding basic operators like `+`, `-`, `*`, `==`, and others to work with our own custom data types (tables acting as objects). By default, Lua doesn't know how to perform these operations on custom objects. But by defining special methods in their metatables, we can tell Lua what these operators should do.  
These special methods are called "metamethods" and are prefixed with double underscores (`__`).  
Let’s say we’re working with a `FoodPortion` class. We want to be able to **add** two portions together or **compare** if they are equal. Instead of creating separate methods like `add` or `equals`, we can overload the `+` and `==` operators to keep our code clean and natural.
```
FoodPortion = {}
FoodPortion.__index = FoodPortion

function FoodPortion:new(grams)
    local o = {
        grams = grams
    }
    setmetatable(o, self)
    return o
end

function FoodPortion.__add(portion1, portion2)
    return FoodPortion:new(portion1.grams + portion2.grams)
end

function FoodPortion.__eq(portion1, portion2)
    return portion1.grams == portion2.grams
end

function FoodPortion.__tostring(portion)
    return portion.grams .. "g"
end

local portion1 = FoodPortion:new(50)
local portion2 = FoodPortion:new(30)
local total = portion1 + portion2 

print("Portion 1: " .. tostring(portion1))
print("Portion 2: " .. tostring(portion2))
print("Total: " .. tostring(total))

print("Portion 1 == Portion 2? " .. tostring(portion1 == portion2))
local portion3 = FoodPortion:new(50)
print("Portion 1 == Portion 3? " .. tostring(portion1 == portion3))
```
In this example: 

- `__add(portion1, portion2)`: This metamethod is invoked when the `+` operator is used with two `FoodPortion` objects. It receives the two operands as arguments and should return a new `FoodPortion` object representing their sum.
- `__eq(portion1, portion2)`: This metamethod is invoked when the `==` operator is used. It should return `true` if the objects are considered equal, `false` otherwise.
- `__tostring(portion)`: This metamethod is called when `tostring()` is applied to a `FoodPortion` object, allowing us to customize its string representation.

Here’s a small list of some operators that we can override using metamethods in Lua:

|**Operator**|**Metamethod to Define**|**Description**|
|---|---|---|
|`+`|`__add(a, b)`|Addition|
|`-`|`__sub(a, b)`|Subtraction|
|`*`|`__mul(a, b)`|Multiplication|
|`/`|`__div(a, b)`|Division|
|`%`|`__mod(a, b)`|Modulo (remainder)|
|`^`|`__pow(a, b)`|Exponentiation|
|`==`|`__eq(a, b)`|Equality comparison|
|`~=`|`__eq(a, b)`|Inequality (if `__eq` is defined, `~=` uses its negation)|
|`<`|`__lt(a, b)`|Less than|
|`<=`|`__le(a, b)`|Less than or equal|
|`>`|`__lt(b, a)`|Greater than (Lua uses `__lt` and `__le` for ordering)|
|`>=`|`__le(b, a)`|Greater than or equal (Lua uses `__lt` and `__le` for ordering)|
|`..`|`__concat(a, b)`|Concatenation|
|`#`|`__len(obj)`|Length operator|
|`obj.key`|`__index(obj, key)`|Accessing a missing key (for getters, inheritance)|
|`obj.key = val`|`__newindex(obj, key, val)`|Assigning to a missing key (for setters, validation)|
|`obj(...)`|`__call(obj, ...)`|Calling the object as a function|
## Error Handling
### Introduction
When writing scripts and code, errors are inevitable. These errors can be syntax errors, such as misspelling a function or variable name, or logical errors, like mistakes in `if` conditions or loops that lead to unexpected behavior. Such errors can cause our program to fail, requiring fixes before the script can run properly.  
Another category is runtime errors, which occur during script execution. These can be caused by invalid user input or unpredictable conditions. While we can’t always prevent runtime errors, Lua provides tools to handle them gracefully.
### Types of Errors
- **Syntax Errors:** These occur when we make mistakes in writing our script, such as misspelling a function or variable name, or forgetting parentheses or keywords. Lua’s parser will catch these before execution.
- **Runtime Errors:** These errors occur while our program is running and cause it to stop. They are often caused by unexpected conditions like invalid user input, attempting to access a non-existent field, or performing an operation on an incorrect data type.
- **Logic Errors:** These errors happen when the code does not work as intended due to incorrect algorithms or logical flaws in conditions. They don't crash the program but cause it to behave in unexpected ways.
- **Arithmetic Errors:** These specifically involve mathematical operations, such as dividing by zero, or improper use of operator precedence.
- **Resource Errors:** These errors occur when we exceed the resources available on our machine, such as running out of memory or hitting recursion limits with infinite loops.
### Lua Errors
Lua's error system is simpler than some other languages, typically using strings or values to represent errors. There isn't a strict hierarchy of error classes.

|**Error Type**|**Description**|**Example (result of `error` function)**|
|---|---|---|
|`syntax error`|Invalid code structure|`syntax error near 'function'`|
|`attempt to index a nil value`|Accessing a field on `nil`|`nil_table.field`|
|`attempt to call a nil value`|Calling a variable that holds `nil`|`nil_function()`|
|`bad argument #1 to '...' (string expected, got number)`|Wrong data type usage for a built-in function|`string.upper(123)`|
|`out of memory`|Exceeding memory limits|_(system dependent)_|
|`Custom Errors`|Developer-defined exceptions|`error("Invalid input")`|
### Handling Runtime Errors
Some errors are caused by user input or unpredictable external conditions, which means that even if our code is clean, there could still be corner cases where an unexpected situation causes the program to crash. To handle such cases, Lua provides a way to catch errors and run alternative statements using `pcall` and `xpcall`.  
The `pcall` (protected call) function is commonly used for error handling. It attempts to execute a given function in "protected mode." If an error occurs during the execution of the function, `pcall` catches it, prevents the program from crashing, and returns a status and the error message.
1. **`pcall(function, ...)`**: This function takes a function and its arguments. It returns `true` (and the function's return values) if the function executes successfully, or `false` (and an error message) if an error occurs.

```
io.write("Enter a:")
local input = io.read()
local n = tonumber(input)

io.write("Enter b:")
local input = io.read()
local m = tonumber(input)

function divid(a,b)
    return a / b
end

local status, result = pcall(divid,n,m)

if not status then
    print("An error occurred: " .. result)
else
    print("The result is "..result)
end
```

- `pcall` returns two values: `status` (a boolean indicating success or failure) and `result` (the return values of the protected function if successful, or the error message if failed).
### Raising Our Own Errors
We can raise our own exceptions (errors) using the `error()` function. This is useful when we want to enforce certain rules in our program and indicate that an abnormal condition has occurred.

```
local function withdraw(balance, amount)
    if amount > balance then
        error("Insufficient funds")
    else
        print("Withdrawing $" .. amount)
    end
end

local status, message = pcall(withdraw, 100, 50)
if not status then
    print("Error: " .. message)
end

local status, message = pcall(withdraw, 100, 150)
if not status then
    print("Error: " .. message)
end
```
When `error("Insufficient funds")` is called, it will cause the execution to stop at that point unless it's wrapped in a `pcall`.
### assert and xpcall
#### assert
The `assert` function helps us test whether a condition is true. It raises an error when the condition is false or `nil`. This is useful for verifying that our program behaves as expected for example, checking if a value matches the expected result or if a specific input produces the intended output. The `assert` function takes two arguments: a condition and an optional error message. If the condition is `true`, `assert` does nothing and returns its arguments. If the condition is `false` or `nil`, it throws an error using the provided message, or a default message if none is given.

```
local age = 25
assert(type(age) == "number" and age >= 0, "Age must be a non-negative number.")

local username = "lua_dev"

assert(username, "Username cannot be nil.")

local result = 10 / 2
assert(result == 5)

-- Example that would cause an error:
-- local temperature = -10
-- assert(temperature >= 0, "Temperature must be non-negative.")
```

If the `assert` condition fails, our program will stop unless we've wrapped the `assert` call within a `pcall`. This makes `assert` very useful for quick validation checks, especially at the beginning of functions to ensure valid arguments.
#### xpcall
While `pcall` is excellent for catching errors, `xpcall` provides an extra layer of control: a **message handler**. This message handler is a function that `xpcall` calls if an error occurs. The error object (usually the error message) is passed to this handler, which can then perform custom error reporting, logging, or even try to recover information before `xpcall` returns its `false` status and the modified error message.  
`xpcall` is particularly useful in more complex applications where we want to:  
- **Log detailed error information:** The message handler can write the error, along with additional context like timestamps or stack traces, to a log file.
- **Format error messages:** We can customize the error message that eventually gets returned by `xpcall`.
- **Perform cleanup:** Before the error propagates, the handler can ensure that resources are released or a consistent state is maintained.

Let's see an example:
```
local function myErrorHandler(err_message)
    print("An error was caught by our custom handler!")
    print("Error message: " .. tostring(err_message))
    return "Custom handled error: " .. tostring(err_message) .. " (details logged)"
end

local function dangerousOperation(a, b)
    if b == 0 then
        error("Cannot divide by zero!")
    end
    return a / b
end

print("--- Using xpcall with a custom handler ---")
local status, result = xpcall(dangerousOperation, myErrorHandler, 10, 0)

if not status then
    print("Operation failed: " .. result)
else
    print("Operation succeeded: " .. result)
end

print("\n--- Using xpcall without an error ---")
local status, result = xpcall(dangerousOperation, myErrorHandler, 10, 2)
if not status then
    print("Operation failed: " .. result)
else
    print("Operation succeeded: " .. result)
end
```

In this example, when `dangerousOperation` errors out, `xpcall` calls `myErrorHandler`. Our handler then prints a custom message and returns a modified error string. This modified string is what `xpcall` then returns as its second value. If no error occurs, the message handler is never called.

`xpcall` gives us fine-grained control over how errors are managed, making our applications more resilient and easier to debug, especially in production environments where graceful error handling is crucial.
### Custom Exception Classes
We can create custom error values that are more structured than simple strings. A common pattern is to error with a table that contains specific error codes or details.
```
local ERRORS = {
    OVERDRAW_ERROR = {code = 1001, message = "Not enough money!"},
    NEGATIVE_AMOUNT_ERROR = {code = 1002, message = "Amount cannot be negative!"}
}

local function withdraw(balance, amount)
    if amount < 0 then
        error(ERRORS.NEGATIVE_AMOUNT_ERROR)
    elseif amount > balance then
        error(ERRORS.OVERDRAW_ERROR)
    else
        print("Withdrawal successful")
    end
end

local status, err_details = pcall(withdraw, 100, 200)

if not status then
    if type(err_details) == "table" and err_details.code == ERRORS.OVERDRAW_ERROR.code then
        print("Custom error (Overdraw): " .. err_details.message)
    elseif type(err_details) == "table" and err_details.code == ERRORS.NEGATIVE_AMOUNT_ERROR.code then
        print("Custom error (Negative Amount): " .. err_details.message)
    else
        print("An unexpected error occurred: " .. tostring(err_details))
    end
end

local status, err_details = pcall(withdraw, 100, -50)
if not status then
    if type(err_details) == "table" and err_details.code == ERRORS.NEGATIVE_AMOUNT_ERROR.code then
        print("Custom error (Negative Amount): " .. err_details.message)
    else
        print("An unexpected error occurred: " .. tostring(err_details))
    end
end
```
In this pattern:
- We define a table `ERRORS` to hold structured error definitions. Each error definition is itself a table with a `code` and `message`.
- When an error occurs, we `error()` with one of these structured error tables.
- In the `pcall`'s error handling block, we check the type of `err_details` and its `code` to identify and react to specific custom errors.
## Tasks:
### Task 1:
Define a `BankAccount` class with:
**Attributes:**
- `accountNumber`: A unique account identifier.
- `ownerName`: The account holder's name.
- `balance`: The current balance (default: `0`).
- `transactions`: Stores transaction history.

**Methods:**
- **`initialize(accountNumber, ownerName, initialBalance = 0)`**
    - Initializes the account with given details.
    - Throws an error if `initialBalance` is negative.
- **`deposit(amount)`**
    - Adds `amount` to the balance.
    - Throws an error if `amount` is negative.
    - Logs the transaction in `#transactions`.
- **`withdraw(amount)`**
    - Deducts `amount` from the balance.
    - Throws an error if:
        - `amount` is negative.
        - Insufficient funds (`balance < amount`).
    - Logs the transaction in `#transactions`.
- **`getBalance()`**
    - Returns the current balance.
- **`getStatement()`**
    - Prints all transactions in a formatted way.
- **`transfer(sourceAccount, targetAccount, amount)`**
    - A **class method** that transfers `amount` from `sourceAccount` to `targetAccount`.
    - Throws an error if the transfer fails.

Use `pcall` to handle:
- Negative deposits/withdrawals.
- Insufficient funds.
- Invalid transfers.

### Task 2:
Create a program to represent the functionality of a robot. The program should have the following:  
**Parent class `Robot` (represents basic robot):** **Attributes:**
- **id**: attribute represents the ID of the robot.
- **x**: represents the coordinate of the robot according to the x-axis.
- **y**: represents the coordinate of the robot according to the y-axis.
- **orientation**: the orientation of the robot (e.g., "north", "east", "south", "west").
- **step**: represents how many steps the robot takes when walking.

**Methods:**
- **constructor**: that initializes the robot's position x, y, and its id. `step` is set by default as 1, no need to pass it as an argument.
- **`turn_clockwise()`**: makes the robot turn 90 degrees clockwise direction.
- **`turn_anticlockwise()`**: makes the robot turn -90 degrees (anti-clockwise) direction.
- **`walk()`**: makes the robot take steps and change its x and y coordinates depending on its orientation.
- **`get_position()`**: prints the position of the robot.

**Child class `NewGenRobot` (represents new generation of robot):** It inherits from the `Robot` class and has these additional features:  
**Attributes:**
- **charge**: how much energy the robot has.
- **turbo_state**: whether the robot is in turbo mode or not.

**Methods:**
- **constructor**: runs the parent class constructor and then assigns a value to `charge`. For `turbo_state`, it's set as `false` by default.
- **`turbo()`**: turns the turbo mode on if `charge > 0`. If `turbo_state` is `true`, `step` is set to 2 and `charge` is reduced by 1.
- **`walk()`**: If `turbo_state` is `true`, it sets `step` to 2 and removes 1 from `charge`. Else, it returns `step` to 1 and `turbo_state` to `false` (this part is slightly ambiguous, interpreting it as "if turbo_state was _just_ active, reset it after a walk"). Then it runs the parent class `walk` method. I will refine this logic for clarity and consistency. The interpretation will be: if turbo is active, use step 2 and consume charge; otherwise, use step 1. Turbo state will be managed by the `turbo()` method.

**Refined `NewGenRobot:walk()` logic:** The `walk` method in `NewGenRobot` will check `self.turbo_state`. If `true`, it will use `self.step = 2` and decrement `self.charge`. If `self.charge` becomes 0 or less, `turbo_state` will be set to `false`. Otherwise, `self.step` will remain at its default of 1. After adjusting `self.step` based on `turbo_state` and `charge`, it will call the parent `Robot:walk()` method.
