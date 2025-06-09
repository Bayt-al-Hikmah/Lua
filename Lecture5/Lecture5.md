## Objectives
- Working with Files 
- Coroutines 

## Working with Files

### Introduction
File handling is a fundamental part of programming. In Lua, working with files allows us to store data permanently, read configuration files, save logs, or even build entire applications that depend on persistent storage.  
Lua provides a simple and powerful way to handle files using its built-in `io` library. This library lets us create, read, write, and modify files with ease.  
There are three main operations we'll focus on:
- **Reading** from files
- **Writing** to files
- **Managing** files (like deleting or renaming)
### Opening Files
To interact with a file, we first need to **open** it. Lua uses the `io.open` function, which can be provided with different **modes** to specify how we want to interact with the file.
#### Common File Modes:
- `"r"`: Read-only (default). Starts from the beginning of the file.
- `"w"`: Write-only. Creates a new file or overwrites an existing one.
- `"a"`: Append. Data will be written at the end of the file. Creates the file if it doesn't exist.
- `"r+"`: Read and write. The file must already exist.
- `"w+"`: Read and write, overwriting the file first.
- `"a+"`: Read and write, appending to the file. Creates the file if it doesn't exist.

**Example: Opening a file for reading** `io.open` returns a file handle if successful, or `nil` and an error message if it fails. It's good practice to check for this.
```
local file, err = io.open("example.txt", "r")

if not file then
  print("Error opening file:", err)
else
  print(file:read("*a")) -- *a reads the whole file
  file:close()
end
```
**Always close the file** after using it with `file:close()` to free up system resources.
### Reading Files
We have a few ways to read data from a file:
- `file:read("*a")`: Reads the entire file.
- `file:read("*l")`: Reads the next line.
- `file:lines()`: An iterator that reads one line at a time, perfect for loops.

**Example: Reading line by line** The `io.lines()` iterator is the most common and efficient way to read a file line-by-line. It also automatically closes the file for us when the loop finishes.
```
for line in io.lines("example.txt") do
  print("Line:", line)
end
```
### Writing to Files
To write to a file, we need to open it in write (`"w"`) or append (`"a"`) mode. If the file doesn't exist, Lua creates it automatically.  
The `file:write()` method is used to write strings to the file. Unlike some other languages, we must add newline characters (`\n`) manually if we want them.  
**Example: Overwriting a file**

```
local file, err = io.open("output.txt", "w")

if file then
  file:write("Hello, world!\n")
  file:write("This is a new file.")
  file:close()
end
```
**Example: Appending to a file**
```
local file, err = io.open("output.txt", "a")

if file then
  file:write("\nAdding another line at the end.")
  file:close()
end
```
### File Existence and Metadata
Lua's standard `io` library is minimal. To check if a file exists, the simplest way is to try opening it for reading.
```
local f = io.open("output.txt", "r")

if f then
  print("File exists.")
  f:close()
else
  print("File does not exist.")
end
```
To get the file size, we can use the `seek` method.
```
local file = io.open("output.txt", "r")
if file then
  local size = file:seek("end") -- Go to the end of the file
  print("File size is:", size, "bytes")
  file:close()
end
```
More advanced operations like checking if a path is a directory require external libraries like **LuaFileSystem (`lfs`)**.
### Deleting and Renaming Files
Lua provides these functions in the `os` (Operating System) library.
- `os.remove(filename)`: Deletes a file.
- `os.rename(oldname, newname)`: Renames a file.
```
-- Rename a file
os.rename("output.txt", "new_output.txt")

-- Delete a file
os.remove("unwanted.txt")
```
## Coroutines

### Introduction
We Think of coroutines as **cooperative threads**. They are like functions that we can pause and resume at any point. Unlike true threads, which the operating system manages and can run simultaneously (preemptive multitasking), coroutines manage themselves. A coroutine only gives up control when we explicitly tell it to, which is called yielding. This makes them a powerful tool for managing state, creating iterators, and handling asynchronous tasks without the complexity of traditional threads.
### Creating and Running Coroutines
We work with coroutines using three main functions from the `coroutine` library:
1. `coroutine.create(f)`: Creates a new coroutine with the body `f` (a function). The coroutine starts in a **suspended** state.
2. `coroutine.resume(co, ...)`: Starts or continues the execution of the coroutine `co`. We can pass arguments to it. It returns a status (`true` for success, `false` for error) and any values passed from `yield` or `return`.
3. `coroutine.yield(...)`: Pauses the execution of the coroutine and passes values back to the `resume` call.
4. `coroutine.status(co)`: Returns the current status of the coroutine `co`. Possible statuses often include:
	- `"suspended"`: The coroutine is created but not yet resumed, or it has yielded.
	- `"running"`: The coroutine is currently executing (this status is usually seen _inside_ the coroutine itself when `coroutine.status(co)` is called).
	- `"normal"`: The coroutine is active but not running (e.g., another coroutine is running).
	- `"dead"`: The coroutine has finished its execution (either by returning or encountering an error).

**Example: A Simple Producer Coroutine** Let's create a coroutine that produces values one at a time.
```
local function numberProducer()
  print("Producer: yielding 1")
  coroutine.yield(1) 

  print("Producer: yielding 2")
  coroutine.yield(2) 
  print("Producer: finished")
end

local co = coroutine.create(numberProducer)

local status, value = coroutine.resume(co)
print("Main: received", value)

status, value = coroutine.resume(co)
print("Main: received", value) 

status, value = coroutine.resume(co)
print("Main: received", value) 

print("Coroutine status:", coroutine.status(co))
```
In this example, the main code "pulls" values from the coroutine whenever it's ready, allowing the `numberProducer` to manage its state between calls.
## Tasks
### Task 1
Make script that read a simple configuration file and make the settings available in your program.
1. **Create a file named `config.txt`** with the following content. Each line is a `key=value` pair.
    ```
    AppName=My Awesome App
    Version=1.2
    User=admin
    LogLevel=debug
    ```
2. **Write a Lua script (`loader.lua`)** that:
    - Opens and reads `config.txt`.
    - Parses each line to separate the key from the value.
    - Stores the settings in a Lua table.
    - Prints a friendly message for each setting it loads, like `"Loaded setting 'AppName' with value 'My Awesome App'"`.
    - After reading the whole file, it should print the final configuration table.
    
**Hint:** You can use `string.find` or `string.gmatch` to split the key and value at the `=` character.

### Task 2:
Create a script that uses coroutines to simulate running two tasks in parallel.
1. **Define two "task" functions:**
    - `task_one`: This function should loop 3 times. In each loop, it prints a message like `"Task One - Step 1"`, and then calls `coroutine.yield()`.
    - `task_two`: This function should loop 4 times. In each loop, it prints a message like `"Task Two - Step A"`, and then calls `coroutine.yield()`.
2. **Write the main part of your script (`scheduler.lua`)** to do the following:
    - Create two coroutines, one for each task function.
    - Create a "scheduler" loop that continues as long as at least one of the coroutines is not dead.
    - Inside the loop, `resume` each coroutine one after the other so their outputs are interleaved.

**Expected output should look something like this:**
```
Task One - Step 1
Task Two - Step A
Task One - Step 2
Task Two - Step B
Task One - Step 3
Task Two - Step C
Task Two - Step D
All task
```