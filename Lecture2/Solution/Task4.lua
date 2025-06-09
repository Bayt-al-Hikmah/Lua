-- Check even / odd
local num = 7
if num % 2 == 0 then
    print(num .. " is even")
else
    print(num .. " is odd")
end

-- Temperature
local temperature = 25  
if temperature > 30 then
    print("Wear shorts")
elseif temperature >= 20 and temperature <= 30 then
    print("T-shirt weather")
else
    print("Bring a jacket")
end