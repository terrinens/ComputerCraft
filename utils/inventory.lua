-- 현재 슬롯에 아이템이 0개 이하라면 인벤토리를 순환하고,
-- 동일한 아이템이 있는 슬롯까지 이동합니다.
function SameItemSoltSelect(target)
    if turtle.getItemCount() == 0 then
        for i = 1, 16 do
            turtle.select(i)
            local iterSlot = turtle.getItemDetail()

            if iterSlot ~= nil and target.name == iterSlot.name then
                break
            end
        end
    end
end

-- 인벤토리 상세 정보 제공
function InvenDetailInfo(started, ended)
    local function yieldIter()
        for i = started, ended do
            local detail = turtle.getItemDetail()
            coroutine.yield(i, detail)
        end
    end

    return coroutine.wrap(yieldIter())
end

function HasItemList()
    local function getName(index)
        turtle.select(index)
        local info = turtle.getItemDetail()
        if info == nil then return false, "" end
        return true, info.name
    end

    local hasItems = {}
    for i = 1, 16 do
        local hasInfo, name = getName(i)
        if hasInfo then
            table.insert(hasItems, { index = i, name = name })
        end
    end
    return hasItems
end

-- 겹칠 수 있는 아이템 겹치기
function SortDuplicateItems()
    local hasItems = HasItemList()


    while #hasItems > 0 do
        for i = 2, #hasItems do
            local temp = hasItems[1]
            local item = hasItems[i]

            if temp.name == item.name then
                turtle.select(temp.index)
                local space = turtle.getItemSpace()

                -- 이동 가능한 갯수가 0개 이상일 경우에만 실행
                if space > 0 then
                    turtle.select(item.index)
                    turtle.transferTo(temp.index, space)
                end
            end
        end
    end
end

-- 인벤토리 정렬 함수 입니다.
-- itemName이 주어질 경우 해당 아이템이 제일 앞선 상태로 정리됩니다.
function Sort(itemName)
    local hasItems = HasItemList()

    table.sort(hasItems, function(a, b)
        if itemName ~= nil then
            if a.name == itemName then
                return true
            elseif b.name == itemName then
                return false
            end
        end
        return a.name < b.name
    end)

    local index = 1
    for _, item in ipairs(hasItems) do
        turtle.select(item.index)
        turtle.transferTo(index)
        index = index + 1
    end
end

function HasItemCheck(itemName)
    local invenDInfo = InvenDetailInfo(1, 16)

    local detail = invenDInfo()
    while detail do
        if detail.name and detail.name:find(itemName, 1, true) then
            return true
        end
    end

    return false
end
