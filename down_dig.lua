local input = tonumber(arg[1])
for _ = 0, input do
    if turtle.detectDown() then turtle.digDown() end        
    turtle.down()
end

