os.loadAPI("/utils/digMove.lua")
local DigForward = digMove.DigForward
local DigDown = digMove.DigDown
local DigUp = digMove.DigUp
local IfFailBack = digMove.IfFailBack
local TurnAround = digMove.TurnAround


-- 해당 함수는 하단 끝점에서부터 사각형의 형태로 채굴을 하는 함수입니다.
-- 터틀은 파고자 하는 방향으로부터 정면으로 있어야 합니다.
-- 정면에서 바라봤을때 왼쪽으로 진행하여 ㄴ형태로 진행됩니다.
-- 작업이 모두 끝난후에는 시작점과 방향이 모두 일치한 형태로 복귀합니다.
-- @param x 사각형 x
-- @param y 사각형 y
-- @param turtleReturn 작동한후 본래자리로 돌아올지 여부입니다. | boolean
function ZigTowDig(x, y, turtleReturn)
    if x <= 0 or y <= 0 then error("x, y > 0") end
    DigForward(x)

    for _ = 2, y do
        DigUp(1)
        TurnAround()
        DigForward(x)
    end

    if turtleReturn == true then
        TurnAround()

        -- 항상 y 보다 한칸 적게 아래로 내려가야한다.
        local totalDown = y - 1;
        if y - 2 >= 2 then
            DigDown(y - 1)
            totalDown = totalDown - (y - 1)
        end

        for _ = 1, totalDown do turtle.down() end

        -- 홀수 y 경우에는 첫 시작점과 다르니 돌아간 상태에서 나아가고, 다시 돌아야 정상적으로 시작점으로 돌아온다.
        if y % 2 ~= 0 then
            DigForward(x)
            TurnAround()
        end
    end
end

-- 터틀은 파고자 하는 블록을 정면에서 바라본 형태로 가운데에 위치 해야합니다.
-- @param x, y 사각형의 크기
-- @param z 총 전진할 수
function ZigThreeDimDig(x, y, z)
    local lx = math.floor(x / 2)
    DigForward(1)

    turtle.turnLeft(1)
    DigForward(lx)

    TurnAround()
    DigForward(x - 1)
    DigUp(1)
    TurnAround()

    ZigTowDig(x - 1, y - 1)
    turtle.down()
    turtle.turnRight()

    for _ = 2, z do
        DigForward(1)
        turtle.turnLeft()
        ZigTowDig(x - 1, y)
        turtle.turnRight()
    end

    if x >= 3 then
        turtle.turnLeft()
        DigForward(x - lx - 1)
        turtle.turnRight()
    end

    IfFailBack(z)
end

-- 연료를 더 아끼기 위한 작동 방식 입니다.
function EnhancedThreeDimDig(x, y, z)
    local lx = math.floor(x / 2)
    x = x - 1
    function InnerFUDig(totalStep, reversal)
        local det, dig
        if reversal == true then
            det, dig = turtle.detectDown, turtle.down
        else
            det, dig = turtle.detectUp, turtle.up
        end

        for _ = 1, totalStep do
            if det() then dig() end
            DigForward()
        end
    end

    function InnerReturn()
        -- 2미만일 경우에는 제대로 작동안하니 수정할것
        TurnAround()
        if x >= 3 then
            turtle.turnLeft()
            DigForward(x - lx - 1)
            turtle.turnRight()
        end
        IfFailBack(z)
    end

    local rEnd = true;
    function InnerTwoDimDig(ix, iy, reversal)
        local yMove = reversal and DigDown or DigUp
        InnerFUDig(ix)
        for _ = 4, iy, 2 do
            yMove(2)
            TurnAround()
            InnerFUDig(ix, reversal)
            rEnd = not rEnd
        end

        if (ix % 2 ~= 0) then
            yMove(1)
            TurnAround()
            DigForward(ix, false)
            rEnd = not rEnd
        end
    end

    local digFunction = (y <= 1) and InnerFUDig or DigForward

    digFunction(1)
    -- 왼쪽 채굴
    turtle.turnLeft()
    digFunction(lx)
    -- 오른쪽 채굴
    TurnAround()
    digFunction(x)
    -- 왼쪽으로 채굴을 위해 회전
    TurnAround()

    if y >= 3 then
        local up = (y == 3) and 1 or 2
        DigUp(up)
        InnerTwoDimDig(x, y - up)
    end

    local frontTurn = rEnd and turtle.turnLeft or turtle.turnRight
    frontTurn()

    
end
