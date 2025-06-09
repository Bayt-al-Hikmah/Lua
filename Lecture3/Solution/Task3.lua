--[[- Define a function `log_message(msg, filter_func)` that:
    - Accepts a string message.
    - Accepts an optional filter function (a closure).
    - If a filter is given, it modifies the message before logging.
    - Otherwise, it logs the message as-is.
- Create a few filters as anonymous functions:
    - `timestamp_filter`: adds current time before the message.
    - `upcase_filter`: converts message to uppercase.
    - `emoji_filter`: adds a smiley emoji after the message.
]]

function log_message(msg, filter_func)
    if filter_func ~= nil then 
        return filter_func(msg)
    end
    return msg
end
function timestamp_filter(msg)
    return os.date("%Y-%m-%d %H:%M:%S")..":: "..msg
end
function upcase_filter(msg)
    return string.upper(msg)
end
function emoji_filter(msg)
    return msg..":D"
end

local message = "Hello Ali "
print(log_message(message, timestamp_filter))