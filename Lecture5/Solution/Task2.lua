function task_one()
    print("Task One - Step 1") 
    coroutine.yield(1)
    print("Task One - Step 2") 
    coroutine.yield(2)
    print("Task One - Step 3") 
    coroutine.yield(3) 
end
function task_two()
    print("Task One - Step A") 
    coroutine.yield(1)
    print("Task One - Step B") 
    coroutine.yield(2)
    print("Task One - Step C") 
    coroutine.yield(3) 
    print("Task One - Step D") 
    coroutine.yield(4) 
end
local co1 = coroutine.create(task_one)
local co2 = coroutine.create(task_two)
while coroutine.status(co1) ~= "dead" or coroutine.status(co2) ~= "dead" do
    if coroutine.status(co1) ~= "dead" then coroutine.resume(co1) end
    if coroutine.status(co2) ~= "dead" then coroutine.resume(co2) end
end
print("All task")