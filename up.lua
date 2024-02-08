local input = tonumber(arg[1])
for _ = 0, input do
    if turtle.detectUp() then turtle.digUp() end
    turtle.up()
end
