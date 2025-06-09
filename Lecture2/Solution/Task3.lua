
local person = {
    name = "John",
    age = 30,
    city = "New York"
}

-- Print the name
print("Name:", person.name)

-- Add occupation
person.occupation = "Developer"
print("Added occupation:", person.occupation)

-- Print all keys
print("All keys:")
for key, _ in pairs(person) do
    print("- " .. key)
end

-- Check if 'age' key exists
local has_age = person.age ~= nil
print("Has 'age' key:", has_age)

-- Merge with hobbies table
local hobbies = { hobbies = {"reading", "coding"} }
for k, v in pairs(hobbies) do
    person[k] = v
end

-- Delete city information
person.city = nil
