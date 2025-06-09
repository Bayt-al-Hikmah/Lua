-- Task 1: Working with colors array
local colors = {"red", "green", "blue"}

-- Print first and last elements
print("First color:", colors[1])        
print("Last color:", colors[#colors])  

-- Add "yellow" to the end
table.insert(colors, "yellow")

-- Insert "black" at the beginning
table.insert(colors, 1, "black")

-- Remove and print the last element
local last = table.remove(colors)
print("Removed color:", last)            

-- Check if "green" exists
local has_green = false
for _, color in ipairs(colors) do
    if color == "green" then
        has_green = true
        break
    end
end
print("Contains 'green':", has_green) 

-- Sorting numbers
local numbers = {5, 3, 8, 1}

-- Sort in ascending order
table.sort(numbers)
print("Sorted numbers:", table.concat(numbers, ", "))