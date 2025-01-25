nPeople = 3
people = {}

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
    return { x = flr(rnd(domeRadius * 2)) - domeRadius, y = flr(rnd(domeRadius * 2)) - domeRadius }
end

function spawnPerson(x, y, z)
    local person = spawnObject(x, y, z)
    person.sprite = flr(rnd({2,5,8,11,18}))
    person.color = flr(rnd({8,10,11}))
    person.burning = 0
    person.inWater = false

    newWaypoint(person)
    -- add any other person-specific parameters here!

    function person.draw(self)
        local x, y = self:getScreenPosition()
        -- add person-specific draw logic here
        pal(7, self.color)
        local h = 1
        if self.wet > 0 then
            y += self.wet
            h = 0.875
        end
        spr(self.sprite, x - 3, y - 7, 1, h)
        pal()

        if self.burning > 0 then
            spr(134 + flr(self.burning / 2) % 5, x - 4, y - 12)
        end
    end

    function person.update(self)
        -- add person-specific update logic here
        stateBasedMove(self)

        if self.burning > 0 then
            self.burning -= 1
        end

        self:updatePhysics()
        
        -- check if in any puddles
        self.wet = 0
        for puddle in all(puddles) do
            local dist = (puddle.x - self.x) * (puddle.x - self.x) + (puddle.y - self.y) * (puddle.y - self.y)
            if puddle.r > 3 and dist < (puddle.r - 2) * (puddle.r - 2) then
                self.wet = max(self.wet, puddle.r - dist > 5 and 2 or 1)
                self.burning = 0
            end
        end
    end

    add(people, person)
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



function stateBasedMove(person)

--[[
states
* idle
* getfood
* runfromfire
* rejoiceinrain
]]

--getfood
--getFood(person)

--idle
idle(person)



end



function getFood(person)

    --food
    local closestFood = { x = 999, y = 999 }
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

    if foodExists then
        foodForcePower = 0.01
    else
        foodForcePower = 0
    end

    local fx = (person.x - closestFood.x) * foodForcePower
    local fy = (person.y - closestFood.y) * foodForcePower

    person.dx = -fx
    person.dy = -fy
end

function idle(person)

    local waypointForcePower = 0.01

    if distanceToPoint(person, person.waypoint) < 3 then
        newWaypoint(person)
    end

    local fx = (person.x - person.waypoint.x) * waypointForcePower
    local fy = (person.y - person.waypoint.y) * waypointForcePower

    person.dx = -fx
    person.dy = -fy
end






--below is archive for future use

--keeping this code, because the Unit lets them move at a constant rate instead of speeding up / slowing down
function unitMove(person)
    local mag = sqrt(fx^2 + fy^2)
    local fxUnit = fx / mag 
    local fyUnit = fy / mag

    local unitMag = sqrt(fxUnit^2 + fyUnit^2)

    local lineScale = 1.5
    --log(fxUnit.."  "..fyUnit.."  "..unitMag)
    debugLine(person.x, person.y, (person.x + fxUnit)*lineScale, (person.y + fyUnit)*lineScale)

    local fxFinal = fxUnit * peopleSpeed
    local fyFinal = fyUnit * peopleSpeed
    
    --local finalForce = {(person.x - closestFood.x) * foodForcePower, (person.y - closestFood.y) * foodForcePower}
    -- negative means they will run towards, positive means they will run away. 
    person.dx = fxFinal
    person.dy = fyFinal
end

--possibly will use for angry state
function randomMove(person)
    -- random numbers: -1 to 1 scaled by speed
    person.dx = (rnd(2) - 1) * peopleSpeed
    person.dy = (rnd(2) - 1) * peopleSpeed
end