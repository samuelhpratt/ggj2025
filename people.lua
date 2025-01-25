nPeople = 10
peopleSpeed = 5



--above the spawnPerson function so can be used
    function newWaypoint(person)
        --return waypoint for you to save
        --doing this way so this function can be used at person init
        local waypoint = generateWaypoint()
        while not withinDomeFootprint(waypoint.x, waypoint.y) do
            waypoint = generateWaypoint()
        end
    
        person.waypoint = waypoint
    end
        
    function generateWaypoint()
        return {x=flr(rnd(domeRadius*2)) - domeRadius, y=flr(rnd(domeRadius*2)) - domeRadius}
    end


function spawnPerson(x, y, z)
    local person = spawnObject(x, y, z)
    person.sprite = flr(rnd({2,5,8,11,18}))
    person.color = flr(rnd({8,10,11}))
    newWaypoint(person)
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

function distanceToPoint(pointA, pointB)
    --accepts anything with x and y parameters
    --so accepts an array of {x=10, y=15}
    --and accepts an object with properties .x and .y

    local dx = pointA.x - pointB.x
    local dy = pointA.y - pointB.y
    return sqrt(dx ^ 2 + dy ^ 2)
end


function weightedMove(person)

    --food
    local closestFood = {x=999, y=999}
    local shortestDistance = 30000
    local foodExists = false
    local dist = 0
    
    for object in all(objects) do
        if object.sprite == objectSprites.food then
            foodExists = true
            dist = distanceToPoint(person, object)
            if dist < shortestDistance then
                closestFood = object
                shortestDistance = dist
            end
        end
    end

    --idle waypoints
    if distanceToPoint(person, person.waypoint) < 3 then
        newWaypoint(person)
        --log("new waypoint")
    end



    --forces

    if foodExists then
        foodForcePower = 0.01
    else
        foodForcePower = 0
    end

    waypointForcePower = 0.01


    local wfx = (person.x - person.waypoint.x) * waypointForcePower
    local wfy = (person.y - person.waypoint.y) * waypointForcePower
    
    --local finalForce = {(person.x - closestFood.x) * foodForcePower, (person.y - closestFood.y) * foodForcePower}
    -- negative means they will run towards, positive means they will run away. 
    person.dx = -wfx
    person.dy = -wfy


end

function randomMove(object)
    -- random numbers: -1 to 1 scaled by speed
    object.dx = (rnd(2) - 1) * peopleSpeed
    object.dy = (rnd(2) - 1) * peopleSpeed
end