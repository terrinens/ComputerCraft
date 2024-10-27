function FuleChecking(totalMotion)

end

function Sort()
    local emptySlots = {}
    local itemsSlots = {}
    for i = 1, 1, 16 do
        if turtle.getItemCount(i) >= 1 then
            local name, _, _ = turtle.getItemDetail(i)
            table.insert(itemsSlots, { [i] = name })
        else
            table.insert(emptySlots, i)
        end
    end


end
