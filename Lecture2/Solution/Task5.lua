print("Enter a number to calculate its factorial:")
local num = tonumber(io.read())
local factorial = 1
local i = 1

if num < 0 then
    print("Factorial is not defined for negative numbers")
else
    while i <= num do
        factorial = factorial * i
        i = i + 1
    end
    print(string.format("%d! = %d", num, factorial))
end

-- Prime numbers between two numbers
print("Enter first number:")
local start = tonumber(io.read())
print("Enter second number:")
local finish = tonumber(io.read())

print("Prime numbers between "..start.." and "..finish..":")
for num = start, finish do
    local isPrime = true
    if num <= 1 then
        isPrime = false
    else
        for i = 2, math.sqrt(num) do
            if num % i == 0 then
                isPrime = false
                break
            end
        end
    end
    if isPrime then
        print(num)
    end
end

-- Even numbers with repeat-until
print("Enter a number:")
local n = tonumber(io.read())
local i = 0

print("Even numbers from 0 to "..n..":")
repeat
    if i % 2 == 0 then
        print(i)
    end
    i = i + 1
until i > n