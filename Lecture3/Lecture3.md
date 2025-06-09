## Objectives
- Working with Functions
- Working with Modules
- Working with External Libraries (LuaRocks)
## Functions
### Introduction
A function is a reusable block of code designed to perform a specific task. Functions are fundamental to writing efficient and well-structured programs. By following the DRY (Don't Repeat Yourself) principle, functions help eliminate code duplication and promote cleaner code. They also make it easier to break down complex problems into smaller, manageable parts, resulting in code that is more organized, easier to understand, and simpler to maintain.
### Creating Functions
We create functions by following these steps:
1. Identify the code to reuse.
2. Choose a function name.
3. Decide what parameters it needs.
4. Define what it should return.

```
function say_hello()
    print("Hello, user!")
end

say_hello() -- Call the function
```

In Lua, we define a function using the `function` keyword, followed by the function name and parentheses `()`. Inside the function, we write the code that should execute when the function is called. The function definition is closed using the `end` keyword.  
To call a function, simply use its name followed by parentheses, as shown above with `say_hello()`.
### Functions with Parameters
We can make a function accept arguments by adding parameters in parentheses after the function name in the definition. Parameters act as placeholders for the values (arguments) we pass when calling the function.  
We can also return a value from the function using the `return` keyword, followed by the value or variable we want to return.
```
function add_two_numbers(num1, num2)
    local result = num1 + num2
    return result
end

local a = add_two_numbers(2, 3)
print(a) -- Output: 5
```
### Optional Parameters
Lua does not have direct support for optional parameters with default values in the function signature like some other languages. However, we can achieve similar functionality by checking if a parameter is `nil` inside the function and assigning a default value if needed.
```
function say_hello(name)
    name = name or "user" -- Assign "user" if name is nil (not provided)
    print("Hello " .. name)
end

say_hello()           -- Output: Hello user
say_hello("Mohamed")  -- Output: Hello Mohamed
```
### Variable Scope
Scope defines the region within a program where a particular variable or function can be accessed and utilized. Lua primarily distinguishes between two main types of scope: **global scope** and **local scope**.
#### Global Scope
Global scope represents the outermost level of a script. Any variable or function defined without the `local` keyword belongs to this global scope. Consequently, global variables and functions can be accessed and used from any part of the Lua program, including within other functions and blocks of code.
#### Local Scope
Local scope restricts the accessibility of a variable or function to the specific block of code where it is defined. When a variable or function is created within a block (like inside a `do...end` block, `if` statement, or another function) using the `local` keyword, it possesses local scope. These local variables and functions are only visible and usable within the boundaries of that particular block and are not accessible from outside its definition.
```
function add_two_numbers(num1, num2)
    local result = num1 + num2 -- 'result' is a local variable
    return result
end

local a = add_two_numbers(2, 3)
print(a) -- Output: 5

-- print(result) -- Error: attempt to access global 'result' (a nil value)
```
In the example above, `result` is a local variable within `add_two_numbers`, so attempting to access it outside that function results in an error because it's not defined in the global scope.
### Arbitrary Number of Parameters 
We can design functions to accept a variable number of arguments using the `...` (ellipsis) notation in the parameter list. When a function is called with multiple arguments corresponding to `...`, Lua gathers all those arguments. We can access them directly as `...` or by assigning them to local variables.
```
function say_hello(...)
    local names = {...} -- Collect all arguments into a table
    for i, name in ipairs(names) do
        print("Hello " .. name)
    end
end

say_hello("Mohamed", "Ahmed", "Ali")
-- Output:
-- Hello Mohamed
-- Hello Ahmed
-- Hello Ali
```
Lua's `...` feature collects all arguments, but it doesn't automatically categorize them into a specific structure like key-value pairs (`**` in some other languages). we need to accept an arbitrary number of named arguments, the common Lua pattern is to pass a table:
```
function process_config(config)
    print("Name: " .. (config.name or "N/A"))
    print("Age: " .. (config.age or "N/A"))
    print("City: " .. (config.city or "N/A"))
end

process_config({name = "Mohamed", age = 30})
-- Output:
-- Name: Mohamed
-- Age: 30
-- City: N/A

process_config({city = "Algiers", interest = "Lua"})
-- Output:
-- Name: N/A
-- Age: N/A
-- City: Algiers
```
### Passing Function as Argument
In Lua, functions are first-class citizens, meaning they can be treated like any other value (e.g., numbers, strings). This allows us to pass functions directly as arguments to other functions, store them in variables, or return them from functions.
```
local function greet(name)
    print("Hello, " .. name .. "!")
end

local function run_callback(callback_func, value)
    callback_func(value) -- Call the passed function
end

run_callback(greet, "Lua") -- Output: Hello, Lua!
```
In this example, `greet` is a function object that can be passed directly. The `run_callback` function accepts this function and executes it.
### Returning Functions
Functions in Lua can also return other functions. This is a powerful feature for creating flexible and dynamic code.
```
local function add(a, b)
    return a + b
end

local function multiply(a, b)
    return a * b
end

local function get_operation(op_type)
    if op_type == "add" then
        return add 
    elseif op_type == "multiply" then
        return multiply
    else
        error("Unknown operation: " .. op_type)
    end
end

local operation = get_operation("multiply")
print(operation(3, 4)) -- Output: 12
```
- `get_operation` returns either the `add` or `multiply` function depending on the argument.
- The selected function is stored in `operation` and then called later.
### Recursive Functions
Recursive functions are special functions that have the ability to call themselves until a certain condition (known as the base case) is met.  
Let's suppose we want to create a function that calculates the factorial of numbers. We know that:

- 0! is equal to 1
- 1! is equal to 1\*0!
- 2! is equal to 2\*1!
- 3! is equal to 3\*2!
- 4! is equal to 4\*3!
- 5! is equal to 5\*4!

With that in mind, we can set the base condition as if n\=\=0 we return 1, otherwise we return n multiplied by the factorial of n−1, and so on.
```
function factorial(n)
    if n == 0 then
        return 1
    else
        return n * factorial(n - 1)
    end
end

print(factorial(5)) -- Output: 120
```

### Anonymous Functions
Anonymous functions (often called closures in Lua when they capture outer variables) are useful when we want to create short, one-time-use functionality without defining a full, named function. In Lua, we can create an anonymous function using the `function(...) ... end` syntax without a name.  
To see how anonymous functions are useful, let's say we want to define a behavior that takes two numbers and an operator, then performs a calculation based on that operator. Here's how we can do this using anonymous functions:
```
local operations = {
    ["+"] = function(a, b) return a + b end,
    ["-"] = function(a, b) return a - b end,
    ["*"] = function(a, b) return a * b end,
    ["/"] = function(a, b) return a / b end -- Lua automatically handles float division
}

local function calculate(a, b, operator)
    if operations[operator] then
        return operations[operator](a, b) -- Call the function stored in the table
    else
        return "Unsupported operator"
    end
end

print(calculate(10, 5, "+")) -- Output: 15
print(calculate(10, 5, "-")) -- Output: 5
print(calculate(10, 5, "*")) -- Output: 50
print(calculate(10, 5, "/")) -- Output: 2.0
```
Here, we created a table of anonymous functions where each operator is mapped to a corresponding function. The `calculate` function then selects and calls the right function based on the operator passed.
We can also send an anonymous function directly as an argument without storing it in a variable:
```
local function apply_operation(func, number)
    return func(number)
end

local number = 5

print("Square of " .. number .. ": " .. apply_operation(function(n) return n * n end, number))
print("Cube of " .. number .. ": " .. apply_operation(function(n) return n * n * n end, number))
print("Double of " .. number .. ": " .. apply_operation(function(n) return n * 2 end, number))
```

### Functional Programming Concepts
Functional programming breaks problems into smaller sub-problems, each solved by pure functions. Functional programming covers the following 5 concepts:
#### Pure Functions:
These functions respect the following:
- They always produce the same output for the same arguments irrespective of anything else.
- They have no side-effects, meaning they do not modify any arguments or local/global variables, or perform input/output operations that change the external state.
- They emphasize immutability. The pure function's only result is the value it returns. They are deterministic.

#### Recursive Functions:
Iteration in functional languages is often implemented through recursion. Recursive functions repeatedly call themselves until they reach a base case.
#### First-Class Functions and Higher-Order Functions:
**First-class functions** are treated as first-class variables. This means they can be passed to functions as parameters, returned from functions, or stored in data structures. **Higher-order functions** are functions that take other functions as arguments and can also return functions.
#### Referential Transparency:
In functional programs, if we replace an expression with its value, it doesn't change the program's behavior. Variables, once defined, ideally don't change their value throughout the program. Functional programs often avoid assignment statements for existing variables. If a new value is needed, a new variable is defined instead. This helps eliminate side effects because any variable can be replaced with its actual value at any point of execution without affecting the program's outcome. The state of any variable is constant at any instant.
#### Variables are Immutable:
In a strict functional programming paradigm, once a variable is initialized, its value cannot be modified. Instead, new variables are created to hold new values. This helps maintain state throughout the runtime of a program. Once a variable is created and its value is set, we can have full confidence knowing that the value of that variable will never change, contributing to predictable behavior and easier debugging.
## Modules
### Introduction
Modules in Lua are a way to organize code into reusable components. They are typically implemented as tables that contain related functions, constants, and data. Modules help organize code into reusable units and are crucial for preventing name collisions between functions, classes, or constants from different parts of a program by creating distinct namespaces.
### Built-in Modules 
Lua comes with a rich set of standard libraries (often thought of as built-in modules) that provide useful functionality out of the box. These libraries are part of Lua's core and provide fundamental operations such as mathematical operations, string manipulation, table handling, file I/O, and more.
#### Using Built-in Modules
Lua's standard libraries are typically accessed through global tables that are always loaded and available by default. We use dot notation to call functions within them. Examples:
- `math`: For mathematical operations like `math.sqrt`, `math.random`.
- `string`: For string manipulation like `string.len`, `string.upper`.
- `table`: For table manipulation like `table.insert`, `table.remove`, `table.sort`.
- `io`: For input/output operations like `io.read`, `io.write`.
- `os`: For operating system specific functions like `os.time`, `os.exit`.

```
print(math.sqrt(25)) -- => 5.0
print(string.upper("hello")) -- => HELLO
```
### Creating Modules
We can create our own modules by defining a Lua file that returns a table. This table will serve as our module, containing the functions and variables we want to expose. The common pattern is to create a local table, add functions/data to it, and then `return` it at the end of the file.
#### Example
Let's create a greeting module and save it as `greetings.lua`:
```
-- greetings.lua
local M = {} -- Create a local table to represent our module

function M.say_hello(name) -- Define a function within our module table
    print("Hello, " .. name .. "!")
end

function M.say_goodbye(name)
    print("Goodbye, " .. name .. "!")
end

return M -- Return the module table
```
To use this custom module, we first require the file where it is defined. The `require` function searches for the module file (by default, in the same directory or specified paths) and executes it, returning the value it exported (our table `M`).
```
-- main.lua
local Greetings = require("greetings") -- Loads greetings.lua and returns its table

Greetings.say_hello("Ali") -- Output: Hello, Ali!
Greetings.say_goodbye("Bob") -- Output: Goodbye, Bob!
```
## External Libraries
### Introduction
**LuaRocks** is the package manager for Lua. It provides a standard format for distributing Lua modules and applications, commonly referred to as "rocks." Each rock contains Lua code along with optional files like documentation, tests, and build instructions. LuaRocks allows developers to easily **share**, **distribute**, and **reuse** useful functionality across different applications, making it similar in concept to "gems" in other language ecosystems.  
LuaRocks help us avoid reinventing the wheel by letting us leverage the work of the wider Lua community.
### Creating LuaRocks
We can create our own LuaRocks to organize and share code across different projects. A rock wraps our functionality inside a clean, versioned, and reusable structure.  
To create a rock, we typically:
1. **Develop our Lua module(s):** We Write our Lua code in one or more `.lua` files, typically structured as a module that returns a table.
2. **Create a `rockspec` file:** This is a small file (with a `.rockspec` extension) that describes our rock. It contains metadata (name, version, license) and instructions on how to build and install our module.
#### Example `myrock-1.0.0.rockspec`:
```
package = "myrock"
version = "1.0.0-1"
source = {
    url = "git://github.com/yourusername/myrock.git", -- Or a local path
    branch = "main"
}
description = {
    summary = "A simple example LuaRock.",
    license = "MIT",
    homepage = "https://github.com/yourusername/myrock"
}
build = {
    type = "builtin",
    modules = {
        myrock = "myrock.lua" -- Map the module name to its file
    }
}
```
#### Example `myrock.lua` (the module file):
```
-- myrock.lua
local M = {}

function M.say_hello(name)
    print("Hello from MyRock, " .. name .. "!")
end

return M
```
To build and install our rock locally (assuming we have LuaRocks installed):
1. We Navigate to the directory containing our `myrock.lua` and `myrock-1.0.0.rockspec` files.
2. Run the command:
```
luarocks make myrock-1.0.0-1.rockspec
```
This command will build and install rour rock into the LuaRocks tree.   
Then we can use our custom rock in any Lua script:
```
-- main_script.lua
local myrock = require("myrock") -- Requires the installed rock

myrock.say_hello("Ali") -- Output: Hello from MyRock, Ali!
```
### Installing Third-Party LuaRocks
Lua provides `luarocks` as the command-line tool to install and manage third-party external libraries (rocks). These rocks are typically hosted on [LuaRocks.org](https://luarocks.org), which is the central repository for Lua libraries.  
If we want to install a rock, we use the `luarocks install` command followed by the rock name:

```
luarocks install lua-cjson
```
Once installed, we can use the rock in our Lua script by requiring it:
```
local http = require("socket.http") -- Example using a common networking rock (LuaSocket)

local response_body, status_code, headers, status_line = http.request("https://api.github.com")

if status_code == 200 then
    print(response_body)
else
    print("Error: " .. status_line)
end
```
## Tasks:
### Task 1
Create a Lua function that tests whether a given number is a prime number or not.
### Task 2
Write a Lua function that converts a decimal number to its binary representation using recursion.
### Task 3
- Define a function `log_message(msg, filter_func)` that:
    - Accepts a string message.
    - Accepts an optional filter function (a closure).
    - If a filter is given, it modifies the message before logging.
    - Otherwise, it logs the message as-is.
- Create a few filters as anonymous functions:
    - `timestamp_filter`: adds current time before the message.
    - `upcase_filter`: converts message to uppercase.
    - `emoji_filter`: adds a smiley emoji after the message.

#### Hint
Use `os.date("%Y-%m-%d %H:%M:%S")` to get the current time.