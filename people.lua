nPeople = 10
peopleSpeed = 5

function spawnPerson(x, y, z)
    local person = spawnObject(x, y, z)
    person.sprite = flr(rnd(2)) + 2
    person.color = flr(rnd({8,10,12}))
    -- add any other person-specific parameters here!

    function person.draw(self)
        local x, y = self:getScreenPosition()
        -- add person-specific draw logic here
        pal(7, self.color)
        spr(self.sprite, x, y - 8)
        pal()
    end

    function person.update(self)
        -- add person-specific update logic here
        --randomMove(self)
        weightedMove(self)

        self:updatePhysics()
    end
end

for i = 1, nPeople do
    spawnPerson(rnd(80) - 40, rnd(80) - 40, 0)
end

--helpers



function distanceToObject(objectA, objectB)
    local dx = objectA.x - objectB.x
    local dy = objectA.y - objectB.y
    return sqrt(dx ^ 2 + dy ^ 2)
end



function weightedMove(person)

    local closestFood = {x=999, y=999}
    local shortestDistance = 30000
    local foodExists = false
    local dist = 0
    
    local foodForcePower = 0.01
    
    

    for object in all(objects) do
        if object.sprite == objectSprites.food then
            foodExists = true
            dist = distanceToObject(person, object)
            if dist < shortestDistance then
                closestFood = object
                shortestDistance = dist
            end
        end
    end

    log(shortestDistance)

    if foodExists then
        local finalForce = {(person.x - closestFood.x) * foodForcePower, (person.y - closestFood.y) * foodForcePower}
        person.dx = -finalForce[1]
        person.dy = -finalForce[2]
    else
        --do nothing
    end


end

function randomMove(object)
    -- random numbers: -1 to 1 scaled by speed
    object.dx = (rnd(2) - 1) * peopleSpeed
    object.dy = (rnd(2) - 1) * peopleSpeed
end