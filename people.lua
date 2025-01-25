nPeople = 10
people = {}

personStates = {
    idle = 1,
    fleeFire = 2,
    seekWater = 3,
    getFood = 4
}

--animation helpers
pT = 0 --person animation time

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
    person.sprite = flr(rnd({2,4,6,8,10,12,14,16,18,20,22}))
    person.color = flr(rnd({8,10,11}))
    person.burning = 0
    person.inWater = false
    person.state = personStates.idle
    person.happiness = 0

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

        -- check if happy enough to hop
        if self.happiness >= 2 then
            if pT == 1 then
                y += 1
            elseif pT == 4 then
                y -= 1
            elseif pT == 8 then
                pT = 0
                --do nothing
            end
            pT += 1
        end

        local flip = false
        local sprite = self.sprite
        if abs(self.dx) > 0.075 or abs(self.dy) > 0.075 then
            sprite += 1
            flip = flr(t() * 5) % 2 == 0
        end

        spr(sprite, x - 3, y - 7, 1, h, flip)
        pal()

        if self.burning > 0 then
            spr(134 + flr(self.burning / 2) % 5, x - 4, y - 12)
        end

    end

    function person.updatePhysics(self)

        --avoid other people
        local otherImpPower = 1
        local otherImpX = 0
        local otherImpY = 0
    
        for other in all(people) do
            -- simple distance check
            if (other.x - self.x) * (other.x - self.x) + (other.y - self.y) * (other.y - self.y) < 9 then
                otherImpX = (other.x - self.x) * otherImpPower
                otherImpY = (other.y - self.y) * otherImpPower
            end
        end
    
        self.dx = self.dx - otherImpX
        self.dy = self.dy - otherImpY


        --bounce off dome
        local domeImpPower = 1.3
        local newX = self.x + self.dx
        local newY = self.y + self.dy

        if not withinDomeFootprint(newX, newY) then

            --bounce

            --play sound
            glassSFX()
            
            --bounce direction
            --if they were going out of the dome at this location, 
            --then going the opposite from that location would bounce them away
            local domeImpX = (newX - self.x) * domeImpPower
            local domeImpY = (newY - self.y) * domeImpPower

            self.x = self.x - domeImpX
            self.y = self.y - domeImpY
        else
            --moves as normal if it didn't bounce off dome
            self.x = newX
            self.y = newY
        end

    end


    function person.update(self)
        -- add person-specific update logic here
        stateBasedMove(self)

        if self.burning > 0 then
            self.burning -= 1
        end

        person.updatePhysics(self)
        
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
    --log(person.state)

    if person.state == personStates.idle then
        idle(person)
        if thereIsFire then
            person.state = personStates.fleeFire
        elseif thereIsFood then
            person.state = personStates.getFood
        else
            --do nothing
        end

    elseif person.state == personStates.fleeFire then
        fleeFire(person)
        if not thereIsFire then
            person.state = personStates.idle
        else
            --do nothing
        end

    elseif person.state == personStates.seekWater then
        seekwater(person)

    elseif person.state == personStates.getFood then
        getFood(person)
        if thereIsFire then
            person.state = personStates.fleeFire
        elseif not thereIsFood then
            person.state = personStates.idle
        else
            --do nothing
        end
    end

end


function idle(person)

    local waypointForcePower = 0.01

    if distanceToPoint(person, person.waypoint) < 3 then
        newWaypoint(person)
    end

    person.dx = -1 * (person.x - person.waypoint.x) * waypointForcePower
    person.dy = -1 * (person.y - person.waypoint.y) * waypointForcePower
end


function getFood(person)

    --food
    local closestFood = { x = 999, y = 999 }
    local shortestDistance = 30000
    local foodExists = #foods > 0
    local dist = 0
    local foodForcePower = 0.03

    if foodExists then
        for food in all(foods) do
            dist = distanceToPoint(person, food)
            if dist < shortestDistance then
                closestFood = food
                shortestDistance = dist
            end
        end

        person.dx = -1 * (person.x - closestFood.x) * foodForcePower
        person.dy = -1 * (person.y - closestFood.y) * foodForcePower
    else
        --do nothing
    end

end


function fleeFire(person)

    --fire
    local closestFire = { x = 999, y = 999 }
    local shortestDistance = 30000
    local fireExists = #fires > 0
    local dist = 0
    local fireForcePower = 0.05

    if fireExists then
        for fire in all(fires) do
            dist = distanceToPoint(person, fire)
            if dist < shortestDistance then
                closestFire = fire
                shortestDistance = dist
            end
        end
    
        person.dx = 1 * (person.x - closestFire.x) * fireForcePower
        person.dy = 1 * (person.y - closestFire.y) * fireForcePower
    else
        --do nothing
    end

end

--for when they are burning
function seekWater(person)
    --here
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