local file, err = io.open("config.txt", "r")
local config
function get_config(file)
    local c = {}
    for line in file:lines() do
        indexs = line:find("=")
        if indexs ~= nil then
            c[line:sub(1,indexs-1)] = line:sub(indexs+1,line:len())
        else
            error("There is Error in the configuration file")
        end
    end
    return c
end

if not file then
    print("Error opening file:", err)
else
    config = get_config(file)
end

print(config["User"])