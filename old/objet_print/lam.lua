os.loadAPI("/utils/digMove.lua")
-- 가로등을 설치합니다.
-- T 형태에 양옆에 랜턴이 설치됩니다.
local function Streetligth()
    turtle.select(1)
    for _ = 1, 5 do
        turtle.up()
        turtle.placeDown()
    end

    turtle.turnLeft()
    turtle.forward()
    turtle.placeDown()

    local function setR()
        turtle.back()
        for _ = 1, 2 do turtle.down() end
        turtle.select(2)
        turtle.place()
        for _ = 1, 2 do turtle.up() end
        turtle.forward()
        turtle.select(1)
    end

    turtle.turnRight()
    setR()

    turtle.turnRight()

    for _ = 1, 2 do turtle.forward() end
    turtle.placeDown()

    turtle.turnLeft()
    setR()

    turtle.turnLeft()

    turtle.forward()
    turtle.turnRight()
end


Streetligth()

for _ = 1, 6 do
    for _ = 1, 9 do turtle.forward() end

    for _ = 1, 5 do turtle.down() end
    Streetligth()
end
