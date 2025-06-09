## Objectives
- Introduction to Programming Languages
- Lua Programming
- Variables and Data Types
- User Input and Output
## Introduction to Programming Languages
Programming languages are tools developed by computer scientists to facilitate communication with machines. Rather than writing complex instructions in binary (which quickly becomes unmanageable for large programs), we use programming languages with more human-readable syntax. These languages make it easier to write, understand, and maintain code.  
Although these high-level languages are easier for humans to use, computers cannot directly understand them. Instead of a compiler, which is commonly used in languages like C, many modern languages like Lua use an interpreter. An interpreter reads the code line by line and executes it directly, without converting the entire program into machine code first. This allows for quick testing and flexibility during development.
## Lua Programming

### Introduction
Lua is a powerful, efficient, lightweight, embeddable scripting language. It was designed to be easy to learn, yet incredibly flexible, making it suitable for a wide range of applications, from game development and web applications to embedded systems. Lua emphasizes simplicity and speed.  
One of Lua's core strengths is its flexibility and its ability to be easily integrated into other applications. It supports multiple programming paradigms, including procedural, object-oriented (via tables), and functional programming, offering versatility for different types of projects.  
Lua is interpreted, meaning there's no need to compile our code. we simply write the code and run it immediately, which makes it great for rapid development and prototyping. Additionally, Lua code is portable: it can run on different systems without needing to be recompiled.
### Installing Lua
To start writing and running Lua programs on our PC, we can follow these steps:
#### On Windows:
- Go to the official Lua website: [https://www.lua.org/download.html](https://www.lua.org/download.html)
- Download the Windows binaries or use a package manager like Chocolatey:
```
    choco install lua
```
    
- Add Lua to your system PATH if not done automatically.
- Open a terminal (Command Prompt or PowerShell), and type `lua -v` to confirm Lua is installed.
#### On macOS:
We can install Lua using Homebrew:
```
brew install lua
```

After the installation, we can check if it worked by typing `lua -v` in the terminal.
#### On Linux:
We can use the system's package manager to install Lua:

```
sudo apt install lua5.4     # for Ubuntu/Debian (or lua5.3, lua)
sudo dnf install lua        # for Fedora
```

Then we check the version using `lua -v`.
### Text Editor vs IDE in Lua Development
A **text editor** is a basic program that allows us to write and format text. We can use any text editor (like VS Code, Sublime Text, or even Notepad) to write Lua code. To execute Lua programs, we just need to have Lua installed on our system no separate compiler is required. We can run Lua code from the command line using the `lua` command.

An **IDE (Integrated Development Environment)** is a more feature-rich environment that often includes a text editor, debugger, file manager, and integrated terminal. For Lua, some popular IDEs and editors with Lua support include ZeroBrane Studio, Visual Studio Code (with Lua extensions), and IntelliJ IDEA (with Lua plugin). These tools often offer syntax highlighting, code completion, and error checking, which make development more efficient.
### Running Our First Lua Program
Let’s write and run our very first Lua program: the classic **"Hello, World!"**.
#### Create the Lua File
We start by opening a text editor or IDE. Then we type the following code:

```
print("Hello, world!")
```

#### Save the File
We save the file with a `.lua` extension:

```
hello.lua
```
The `.lua` tells our system that this is a Lua script file.

#### Run the Program
To run our program, we open the terminal or command prompt, navigate to the folder where we saved the file, and type:
```
lua hello.lua
```

If everything is set up correctly, we’ll see the message:

```
Hello, world!
```
## Variables and Data Types

### Variables
Variables serve as the fundamental building blocks in our programs, they're like labeled storage containers that hold our data. These containers can store various types of information including numbers, text (strings), true/false values (booleans), and more complex data structures like tables.  
Lua is a Dynamically Typed language; it automatically determines the variable type at runtime, so we don't need to explicitly declare types. This gives us flexibility to assign different data types to the same variable.
#### Creating Variables
To create a variable in Lua, we start by choosing a meaningful name. Variable names should:
- Begin with a letter or an underscore (`_`)
- Contain only letters, numbers, or underscores  

We assign a value to a variable using the `=` symbol. Variables declared without a `local` keyword are global by default. It's generally good practice to use `local` for variables within a specific scope to avoid polluting the global namespace.
```
local name = "Alice"
local age = 25
local greeting_message = "Hello, " .. name .. "!"
```
### Data Types
Lua supports several built-in data types that allow us to store, manipulate, and interact with different kinds of information.
#### Numbers
Lua supports floating-point numbers by default for all numerical values. This means both integers and decimal numbers are treated as the same type.
```
local age = 30           -- Integer value, stored as float
local price = 19.99      -- Float value
```
We can perform arithmetic operations using the following operators:

- `+` (addition)
- `-` (subtraction)
- `*` (multiplication)
- `/` (division, always float result)
- `%` (modulus or remainder)
- `^` (exponent)
- `//` (floor division, Lua 5.3+)


```
local total = 10 + 5
local half = 20 / 2.0
```

#### Strings
Strings are sequences of characters enclosed in either **double** (`"`) or **single** (`'`) quotes. We use them to store text such as names, sentences, or messages.

```
local name = "Alice"
local greeting = 'Hello, world!'
```
We can combine (concatenate) strings using the `..` operator:
```
local first_name = "Alice"
local last_name = "Joly"
local greet = "Hello, " .. first_name .. " " .. last_name .. "!"
```
Strings in Lua are immutable. We can use functions from the `string` library for manipulation, like `string.len`, `string.upper`, `string.lower`, etc.
#### Booleans
Boolean data types represent **logical values**: `true` or `false`. They're commonly used in conditions, comparisons, and control structures.
```
local is_logged_in = true
local has_permission = false
```
#### Tables
Tables are the only data structuring mechanism in Lua and are incredibly versatile. They are associative arrays, meaning they can be indexed with numbers (like arrays), strings (like dictionaries/hashes), or even other Lua values.
```
-- Array-like table
local colors = {"red", "green", "blue"}
print(colors[1])    -- => "red"

-- Dictionary-like table
local person = {
    name = "Alice",
    age = 30
}
print(person.name)  -- => "Alice"
print(person["age"]) -- => 30 (alternative access)
```
Lua tables can hold values of **any type**, including other tables:
```
local mixed = {1, "hello", true, {nested = true}}
```

We can use functions like `table.insert`, `table.remove`, `table.getn` (or `#table` for sequence length) to manipulate tables.
#### Nil
The special value `nil` represents **"nothing"** or **"no value"** in Lua. It’s Lua's version of `null`.
```
local middle_name = nil
```
`nil` is commonly used to indicate the absence of a value, such as when a variable hasn't been assigned yet, or a table key doesn't exist. Assigning `nil` to a global variable removes it.
### Constants
Lua does not have a built-in concept of "constants" like some other languages. By convention, variables meant to hold values that should not change are often named in **ALL_CAPS**. However, these are still regular variables and can be reassigned.

```
PI = 3.14159
MAX_USERS = 100
DEFAULT_TIMEOUT = 30
```
For true immutability or a more robust constant definition, one might use metatables or ensure they are only assigned once.
### Converting Between Types
Lua handles type conversions primarily through global functions.
#### Convert to Number
We use `tonumber()` to convert a value to a **number**:

```
tonumber("42")      -- => 42
tonumber("3.14")    -- => 3.14
tonumber("hello")   -- => nil (non-numeric strings become nil)
```
#### Convert to String
We use `tostring()` to convert a number or boolean into a **string**:
```
tostring(100)       -- => "100"
tostring(true)      -- => "true"
```
### Comments
Comments are notes we write in our code to explain what it does. They are ignored by Lua when the program runs; they're just for us (and other humans) to understand the code better.
#### Single-line Comments
We use the `--` symbol for single-line comments. Anything after the `--` on that line is treated as a comment.
```
-- This is a single-line comment
print("Hello, world!")  -- This prints a greeting to the screen
```
#### Multi-line Comments
For multi-line comments, we use `--[[` to start the block and `--]]` to end it.
```
--[[
This is a multi-line comment.
It spans several lines.
Useful for larger comment blocks.
--]]
```
## User Input and Output
In most programs, interacting with the user is essential. Lua makes it easy to display information (output) and receive input from the user.
### Output
We use the `print()` function to show text on the screen. It automatically adds a newline after the output.
```
print("Hello!")     -- => Hello!
```
To print without a newline, we can use `io.write()`.
```
io.write("Hi")
io.write(" there!\n") -- => Hi there!
```
#### Escape Characters
Escape characters start with a backslash (`\`) and are used to include special characters inside strings.

|Escape|Meaning|Example|
|:--|:--|:--|
|`\n`|Newline|`"Line 1\nLine 2"`|
|`\t`|Tab space|`"Name:\tAlice"`|
|`\\`|Backslash (`\`)|`"C:\\Users\\Alice"`|
|`\"`|Double quote|`"He said, \"Hello!\""`|
|`\'`|Single quote|`'It\'s fine.'`|

```
print("She said, \"Welcome!\"\nLet's start learning Lua.\n")
```
**Output**
```
She said, "Welcome!"
Let's start learning Lua.
```
### Input

To get input from the user, we use the `io.read()` function. It waits for the user to type something and press Enter.
```
io.write("What's your name? ")
local name = io.read()
print("Nice to meet you, " .. name .. "!")
```
`io.read()` captures the newline (`\n`) when the user presses Enter in some environments. To read a single line and potentially remove the trailing newline, using `io.read("*l")` is common for line-by-line reading. However, often a simple `io.read()` effectively reads a line.
#### Getting Numeric Input
All input from `io.read()` is treated as a **string** by default. If we want a number, we need to convert it using `tonumber()`:
```
io.write("Enter your age: ")
local age_str = io.read()
local age = tonumber(age_str)

if age then -- Check if conversion was successful
    print("In 5 years, you'll be " .. (age + 5) .. " years old!")
else
    print("Invalid age entered. Please enter a number.")
end
```
## Tasks
### Task 1
Write a program that reads the radius of a circle from the user and then displays its surface area. 
### Task 2
Develop a temperature converter that converts from Celsius to Fahrenheit. 