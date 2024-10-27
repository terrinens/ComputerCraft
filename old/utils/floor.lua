os.loadAPI("/utils/inventory.lua")
os.loadAPI("/utils/digMove.lua")
local DigForward = digMove.DigForward
local DigDown = digMove.DigDown
local DigUp = digMove.DigUp
local IfFailBack = digMove.IfFailBack
local TurnAround = digMove.TurnAround


-- 왼쪽 하단끝점에서 바꾸고자 하는 바닥의 끝점에서 부터 정면을 바라본 상태에서 시작합니다.
-- 여기서 정면이란 y축을 바라본 상태입니다.
function FloorReplacement(replaItemNumber, x, y)
    --if not inventory.HasItemCheck(replaItemNumber) then error("no has item") end
    --inventory.Solt()
    local slot = 1
    turtle.select(slot)
    local function slotChange()
        if turtle.getItemCount() == 0 then
            slot = slot + 1
            turtle.select(slot)
        end
    end

    for i = 1, x do
        for j = 1, y do
            slotChange()
            turtle.digDown()
            turtle.placeDown()
            if j ~= y then turtle.forward() end
        end

        local turn = (i % 2 ~= 0) and turtle.turnRight or turtle.turnLeft
        turn()
        turtle.forward()
        turn()
    end
end
