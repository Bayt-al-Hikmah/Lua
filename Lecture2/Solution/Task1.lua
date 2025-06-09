local word = "Developer"

-- Print first and last characters
print("First character:", string.sub(word, 1, 1))
print("Last character:", string.sub(word, -1))
-- Convert to uppercase and print
print("Uppercase version:", string.upper(word))


local phrase = "I love Python"
-- Replace "Python" with "Lua" and print
local updated_phrase = string.gsub(phrase, "Python", "Lua")
print("Updated phrase:", updated_phrase)


local sentence = "Learning Lua is fun"
-- Check if "Lua" is in the sentence
local has_lua = string.find(sentence, "Lua") ~= nil
print("Contains 'Lua':", has_lua)                  -- true
-- Print number of characters in the sentence
print("Character count:", #sentence) 