local x = tonumber(arg[1])

local function line()
    for _ = 1, x do
        turtle.dig()
        turtle.digUp()
        turtle.forward()
    end

    for _ = 1, x do 
        turtle.back()
    end
end

line()
