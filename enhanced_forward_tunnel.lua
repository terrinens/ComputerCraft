local z = tonumber(arg[1])
local x = tonumber(arg[2])
local y = tonumber(arg[3])

local function digAction(detectAction, digAction)
    while detectAction() do digAction() end
end

local function moveAction(moveAction, moveFailAction)
    while not moveAction() do moveFailAction() end
end

-- x 좌표만 보는 형태 not returns
local function xDig(digUp, place)
    for ix = 1, x do
        if place then turtle.placeDown() end
        digAction(turtle.detect, turtle.dig)
        if digUp then turtle.digUp() end
    end
end

local function endpointTurn()
    for _ = 1, 2 do
        turtle.turnLeft()
        moveAction(turtle.up, turtle.digUp)
    end
end

local function yEndpointReturn()
    for _ = 1, y do moveAction(turtle.down, turtle.digDown) end
end

local function oddY()
    for iy = 1, y, 2 do
        -- if y = 5 : 1 3 5
        local place = iy == 1
        local notEndPoint = iy ~= y

        xDig(notEndPoint, place)
        endpointTurn()
    end

    yEndpointReturn()
end

local function evenY()
    for iy = 1, y, 2 do
        -- if y = 6 : 1, 3, 5 y 하나 빈다.
        local place = iy == 1
        xDig(true, place)
        endpointTurn()
    end

    for _ = 1, 1 do
        for _ = 1, 2 do turtle.turnLeft() end
        xDig(false, false)
    end

    yEndpointReturn()
end

local function start()
    local even = y % 2 == 0;

    if even then
        evenY()
    else
        oddY()
    end
end

start()
