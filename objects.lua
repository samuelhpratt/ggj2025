-- objects have x, y, z position and a type (food, hat, toy etc)
-- 0, 0, 0 is the center of the dome
objects = {}

function drawObjects()
    local objectSprites = {
        food = 1,
        person = 2,
        toy = 3,
        hat = 4
    }

    local objectExistingColors = {
        food = nil,
        person = 7,
        toy = nil,
        hat = nil
    }

    sortByY(objects)

    for object in all(objects) do
        
        --replace colors if they have a replacement color defined
        if object.replacementColor != nil then
            pal(objectExistingColors[object.type],object.replacementColor)
        end

        --draw the sprite
        spr(
            objectSprites[object.type],
            64 + object.x,
            domeY - 8 + object.y * domeAngle - object.z * (1 - domeAngle)
        )

        pal() --clearing palette changes if they were made
    end
end

function updateObjects()
    local gravity = .5
    for object in all(objects) do
        
        --x & y movement
        local newX = object.x + object.dx
        local newY = object.y + object.dy
        if withinDomeFootprint(newX, newY) then
            object.x = newX
            object.y = newY
        end

        --z movement
        object.dz -= gravity
        object.z += object.dz
        if object.z < 0 then
            object.z = 0
            object.dz = 0
        end
    end
end

function withinDomeFootprint(x, y)
    local padding = 5
    local dx = x - 0 --dome x centre is 0
    local dy = y - 0 --dome y centre is 0
    local dist = sqrt(dx^2 + dy^2)

    return dist <= (domeRadius - padding)
end

function spawnObject(x, y, z, type, replacementColor)
    replacementColor = replacementColor or nil
    local object = { x = x, y = y, z = z, dx = 0, dy = 0, dz = 0, type = type, replacementColor = replacementColor}
    add(objects, object)
    return object
end

function sortByY(array)
    for i = 1, #array do
        local j = i
        while j > 1 and array[j - 1].y > array[j].y do
            array[j], array[j - 1] = array[j - 1], array[j]
            j = j - 1
        end
    end
end