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

    for i,object in ipairs(objects) do
        object:draw()
    end
end

function updateObjects()
    for object in all(objects) do
        object:update()
    end
end

function withinDomeFootprint(x, y)
    local padding = 5
    local dx = x - 0
    --dome x centre is 0
    local dy = y - 0
    --dome y centre is 0
    local dist = sqrt(dx ^ 2 + dy ^ 2)

    return dist <= (domeRadius - padding)
end

function spawnObject(x, y, z, s)
    local object = { x = x, y = y, z = z, dx = 0, dy = 0, dz = 0, sprite = s }

    object.updatePhysics = function(self)
        local newX = self.x + self.dx
        local newY = self.y + self.dy
        if withinDomeFootprint(newX, newY) then
            self.x = newX
            self.y = newY
        end

        -- gravity
        self.dz -= .5
        self.z += self.dz
        if self.z < 0 then
            self.z = 0
            self.dz = 0
        end
    end

    object.update = function(self)
        self:updatePhysics()
    end

    
    object.draw = function(self)
        local x, y = self:getScreenPosition()
        spr(self.sprite, x, y - 8)
    end

    object.getScreenPosition = function(self)
        return 64 + self.x, domeY + self.y * domeAngle - self.z * (1 - domeAngle)
    end

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