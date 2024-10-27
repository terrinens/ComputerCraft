local x = tonumber(arg[1])
local y = tonumber(arg[2])
local z = tonumber(arg[3])


local function xPositionInit()
    for _ = 1, x do
        turtle.back()
    end
end

local function line()
    for _ = 1, x do
        turtle.digDown()
        turtle.forward()
    end
    xPositionInit()
end

local function yPositionInit()
    turtle.turnLeft()
    for _ = 1, x do
        turtle.forward()
    end
    turtle.turnRight()
end

local function flat()
    for _ = 1, y do
        line() -- 종료시점에서 북쪽 방향
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft() -- 다시 정면
    end
    yPositionInit()
end



local function start()
    for _ = 1, z do
        flat()
        turtle.down()
    end
end

start()
