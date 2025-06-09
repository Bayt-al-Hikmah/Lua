function isPrime(num)
    for i = 2,math.sqrt(num) do
        if num % i == 0 then
            return false
        end
    end
    return true
end 

io.write("Enter number: ")
n = tonumber(io.read())
print("Is prime " ..n.. " ? " .. tostring(isPrime(n)))