local z = tonumber(arg[1])
local x = tonumber(arg[2])
local y = tonumber(arg[3])

local function fuleCheck()
    local totalMove = z * x * y
    local nowFuel = turtle.getFuelLevel()

    if totalMove > nowFuel then
        error('Lack of fuel')
    elseif totalMove > turtle.getFuelLimit() then
        error('Over Limit of fuel')
    end
end

local function moveAction(action, failed)
    if not action() then
        failed()
        action()
    end
end

-- 바라본 x dig
local function xLine(place)
    for ix = 1, x do
        if place then turtle.placeDown() end

        turtle.dig()
        turtle.turnLeft()
        if ix ~= x then moveAction(turtle.forward, turtle.dig) end
        turtle.turnRight() -- 정면
    end

    -- position init
    turtle.turnRight() -- 시작 위치 바라보기

    for _ = 2, x do    -- x 포지션은 totalX - 1
        turtle.forward()
    end

    turtle.turnLeft() -- 정면
end

local function yLine()
    for iy = 1, y do
        xLine(iy == 1)
        if iy ~= y then moveAction(turtle.up, turtle.digUp) end
    end

    for _ = 1, y do turtle.down() end
end

local function start()
    for _ = 1, z do
        yLine()
        turtle.forward()
    end
end


start()
