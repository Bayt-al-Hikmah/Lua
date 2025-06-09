local Robot = {}
Robot.__index = Robot

function Robot:new(id, x, y)
    local robot = {
        id = id,
        x = x or 0,
        y = y or 0,
        orientation = "north",
        step = 1
    }
    setmetatable(robot, self)
    return robot
end

function Robot:turn_clockwise()
    local orientations = {"north", "east", "south", "west"}
    local current_index = nil

    for i, orientation in ipairs(orientations) do
        if self.orientation == orientation then
            current_index = i
            break
        end
    end
    
    self.orientation = orientations[current_index % #orientations + 1]
end

function Robot:turn_anticlockwise()
    local orientations = {"north", "west", "south", "east"}
    local current_index = nil
    
    for i, orientation in ipairs(orientations) do
        if self.orientation == orientation then
            current_index = i
            break
        end
    end
    
    self.orientation = orientations[current_index % #orientations + 1]
end

function Robot:walk()
    if self.orientation == "north" then
        self.y = self.y + self.step
    elseif self.orientation == "east" then
        self.x = self.x + self.step
    elseif self.orientation == "south" then
        self.y = self.y - self.step
    elseif self.orientation == "west" then
        self.x = self.x - self.step
    end
end

function Robot:get_position()
    print(string.format("Robot %s is at (%d, %d) facing %s", 
          self.id, self.x, self.y, self.orientation))
end

local NewGenRobot = setmetatable({}, {__index = Robot})
NewGenRobot.__index = NewGenRobot

function NewGenRobot:new(id, x, y, charge)
    local robot = Robot:new(id, x, y)
    setmetatable(robot, self)
    
    robot.charge = charge or 0
    robot.turbo_state = false
    
    return robot
end

function NewGenRobot:turbo()
    if self.charge > 0 then
        self.turbo_state = not self.turbo_state
        if self.turbo_state then
            self.step = 2
        else
            self.step = 1
        end
    else
        self.turbo_state = false
        self.step = 1
    end
end

function NewGenRobot:walk()
    if self.turbo_state and self.charge > 0 then
        self.step = 2
        self.charge = self.charge - 1
        if self.charge <= 0 then
            self.turbo_state = false
        end
    else
        self.step = 1
        self.turbo_state = false
    end
    
    Robot.walk(self)
end

-- Tests
local basic_robot = robots.Robot:new("R2D2", 0, 0)
basic_robot:get_position()

basic_robot:walk()
basic_robot:get_position()  

basic_robot:turn_clockwise()
basic_robot:walk()
basic_robot:get_position()  

basic_robot:turn_anticlockwise()
basic_robot:walk()
basic_robot:get_position() 

local advanced_robot = robots.NewGenRobot:new("C3PO", 0, 0, 3)
advanced_robot:get_position()  

advanced_robot:turbo() 
advanced_robot:walk()
advanced_robot:get_position()  

advanced_robot:turn_clockwise()
advanced_robot:walk()
advanced_robot:get_position() 

advanced_robot:walk()  
advanced_robot:get_position() 

advanced_robot:walk()
advanced_robot:get_position()  