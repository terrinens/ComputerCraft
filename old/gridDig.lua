os.loadAPI("/utils/dig.lua")

local x = tonumber(arg[1])
local y = tonumber(arg[2])
local z = tonumber(arg[3])

if not x or not y or not z then
    error("plz Start main x, y, z")
end

print("The Size as " .. x .. " * " .. y)
print("Forward as " .. z)
print("Start!")

dig.ZigThreeDimDig(x, y, z)
