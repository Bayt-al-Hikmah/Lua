function tobinary(n)
    if n == 0 then
        return 0
    end
    return n % 2 + 10 * tobinary(math.floor(n/2))
end

io.write("Enter number: ")
local n = tonumber(io.read())
print(n.. "on binary equal to " ..tobinary(n))