os.loadAPI("/utils/inventory.lua")

-- 씨앗과, 생산물이 동일할때 사용하는 함수입니다.
-- 이때 바라보는 방향은 왼쪽 하단에서 y축을 바라본 형태여야 합니다.
-- 만약 x축과 y축이 동일하다면 왼쪽 하단 어느곳에서 시작하던 동일한 작동방식입니다.
-- 앞으로 전진시 이동에 실패할 경우 터틀이 바라보는 옆으로 이동하여 다음칸으로 이동하려 시도합니다.
function SeedsSameProducts(x, y)
    turtle.up()
    turtle.select(1)
    local seed = turtle.getItemDetail()


    for ix = 1, x do
        -- 특정 상황에서 y축의 총 이동수가 줄어드는 경우가 발생하므로 정의한다.

        local function turn(total, reversed)
            if total == nil then total = 1 end

            local inTurn = (ix % 2 ~= 0) and turtle.turnRight or turtle.turnLeft
            if reversed then
                inTurn = (inTurn == turtle.turnRight) and turtle.turnLeft or turtle.turnRight
            end

            for _ = 1, total do inTurn() end
        end

        local recodeY = y
        while recodeY >= 0 do
            inventory.SameItemSoltSelect(seed)
            if not turtle.forward() then
                turn()
                turtle.forward()
                turn(1, true)
                for _ = 1, 2 do turtle.forward() end
                turn(1, true)
                turtle.forward()
                turn()
                recodeY = recodeY - 1
            end
            turtle.digDown()
            turtle.placeDown()
            recodeY = recodeY - 1
        end

        turn()
        turtle.forward()
        turn()
    end
end
