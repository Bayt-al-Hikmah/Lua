io.write("Enter temperature in Celsius: ")
local celsius = tonumber(io.read())  
local fahrenheit = (celsius * 9/5) + 32  
print(celsius.. "°C = "..fahrenheit.."°F")
