function TurnAround()
    for _ = 1, 2 do turtle.turnLeft() end
end

-- 앞채굴, 전진 함수
function DigForward(totalStep)
    for i = 1, totalStep do
        -- 성능 향상을 위한 탐지 했을 경우에만 채굴
        -- 흙 같은 경우에는 그냥 길을 만들어버리고 끝나는 경우가 있으므로 여러번 채굴을 시도한다.
        local tryCount = 0
        while turtle.detect() and tryCount <= 5 do
            if not turtle.dig() then tryCount = tryCount + 1 end
            os.sleep(0.05)
        end
        tryCount = 0

        if not turtle.forward() then return false, i end
    end
    return true, -1
end

-- 하단 채굴, 하단 이동 함수
function DigDown(totalStep)
    for _ = 1, totalStep do
        if turtle.detectDown() then turtle.digDown() end
        turtle.down()
    end
end

-- 상단 채굴, 상단 이동 함수
function DigUp(totalStep)
    for _ = 1, totalStep do
        if turtle.detectUp() then turtle.digUp() end
        turtle.up()
    end
end

-- 뒤로가기 실패시, 뒤로 돌아 채굴을 시도합니다.
-- 그 이후 다시 정면을 바라봅니다.
function IfFailBack(totalStep)
    for _ = 0, totalStep do
        if not turtle.back() then
            TurnAround()
            while turtle.detect() do
                turtle.dig()
            end
            TurnAround()
        end
    end
end
