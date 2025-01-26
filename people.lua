nPeople = 5
people = {}
selectedPerson = nil

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
    person.sprite = flr(rnd { 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22 })
    person.color = flr(rnd { 8, 10, 11, 12 })
    person.burning = 0
    person.inWater = false
    person.state = personStates.idle
    person.happiness = 0
    person.dx = 0
    person.dy = 0
    -- add any other person-specific parameters here!

    function person.draw(self)
        local x, y = self:getScreenPosition()
        local h = 1
        if self.wet > 0 then
            y += self.wet
            h = 0.875
        end

        local flip = false
        local sprite = self.sprite
        if abs(self.dx) > 0 or abs(self.dy) > 0 then
            sprite += 1
            flip = flr(t() * 5) % 2 == 0
        end

        if self == selectedPerson then
            pal(7, 0)

            spr(sprite, x - 3, y - 6, 1, h, flip)
            spr(sprite, x - 4, y - 7, 1, h, flip)
            spr(sprite, x - 2, y - 7, 1, h, flip)
            spr(sprite, x - 3, y - 8, 1, h, flip)
        end

        pal(7, self.color)
        spr(sprite, x - 3, y - 7, 1, h, flip)
        pal()

        -- debug - show state
        -- print(person.state, x - 2, y - 12, 0)

        if self.burning > 0 then
            spr(134 + flr(self.burning / 2) % 5, x - 4, y - 12)
        end
    end

    function person.getDialogue(self)
        local options = { "generic" }
        if self.burning > 0 then
            options = { "fire" }
        end
        if self.wet > 0 then
            add(options, "water")
        end
        return rnd(dialogueLines[rnd(options)])
    end

    function person.updatePhysics(self)
        -- friction?
        --avoid other people
        local otherImpPower = 1

        for other in all(people) do
            -- simple distance check
            if other ~= self then
                local dist2 = (other.x - self.x) * (other.x - self.x) + (other.y - self.y) * (other.y - self.y)
                if dist2 < 25 then
                    local dist = sqrt(dist2)
                    self.dx -= (other.x - self.x) * otherImpPower / (dist * dist)
                    self.dy -= (other.y - self.y) * otherImpPower / (dist * dist)
                end
            end
        end

        local maxSpeed = 0.5
        if self.state == personStates.fleeFire then
            maxSpeed = 1.5
        end
        if self.burning > 0 then
            maxSpeed = 2
        end
        if abs(self.dx) > maxSpeed then
            self.dx = sgn(self.dx) * maxSpeed
        end
        if abs(self.dy) > maxSpeed then
            self.dy = sgn(self.dy) * maxSpeed
        end

        if abs(self.dx) < 0.1 then
            self.dx = 0
        end
        if abs(self.dy) < 0.1 then
            self.dy = 0
        end

        self.x += self.dx
        self.y += self.dy

        if not withinDomeFootprint(self.x, self.y) then
            -- if they are going out of the dome, snap them back into it and invert speed

            local dist = sqrt(self.x * self.x + self.y * self.y)
            local nx, ny = self.x / dist, self.y / dist

            -- bounce off glass
            local k = -2 * (self.dx * nx + self.dy * ny)
            self.dx += k * nx
            self.dy += k * ny

            -- snap inside dome
            self.x *= (domeRadius - domePadding) / dist
            self.y *= (domeRadius - domePadding) / dist

            --play sound
            glassSFX()
        end

        self.dz -= .5
        self.z += self.dz
        if self.z < 0 then
            self.z = 0
            self.dz = 0
        end
    end

    function person.update(self)
        -- add person-specific update logic here
        stateBasedMove(self)

        if self.burning > 0 then
            self.burning -= 1
            
            person.happiness -= 1
            if person.happiness < -2 then
                person.happiness = -2
            end
        end

        if selectedPerson == self then
            self.dx = 0
            self.dy = 0
        end

        self:updatePhysics()

        -- check if happy enough to hop
        if self.happiness >= 2 and self.dx == 0 and self.dy == 0 and self.z == 0 then
            self.dz = 3
        end

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
        elseif thereIsFood and person.happiness < 3 then
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

    if person.waypoint then
        person.dx += -1 * (person.x - person.waypoint.x) * waypointForcePower
        person.dy += -1 * (person.y - person.waypoint.y) * waypointForcePower

        if distanceToPoint(person, person.waypoint) < 3 then
            person.waypoint = nil
        end
    else
        person.dx *= 0.5
        person.dy *= 0.5
        if rnd() < 0.02 then
            newWaypoint(person)
        end
    end
end

function getFood(person)
    --food
    local closestFood = nil
    local closestDist = nil
    local foodForcePower = 1

    for food in all(foods) do
        if food.z == 0 then
            local dist = distanceToPoint(person, food)
            if not closestDist or dist < closestDist then
                closestFood = food
                closestDist = dist
            end
        end
    end

    if closestFood then
        if closestDist < 2 then
            person.happiness += 1
            del(objects, closestFood)
            del(foods, closestFood)
        else
            person.dx += -1 * (person.x - closestFood.x) * foodForcePower / closestDist
            person.dy += -1 * (person.y - closestFood.y) * foodForcePower / closestDist
        end
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

        person.dx += 1 * (person.x - closestFire.x) * fireForcePower
        person.dy += 1 * (person.y - closestFire.y) * fireForcePower
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
    local mag = sqrt(fx ^ 2 + fy ^ 2)
    local fxUnit = fx / mag
    local fyUnit = fy / mag

    local unitMag = sqrt(fxUnit ^ 2 + fyUnit ^ 2)

    local lineScale = 1.5
    --log(fxUnit.."  "..fyUnit.."  "..unitMag)
    debugLine(person.x, person.y, (person.x + fxUnit) * lineScale, (person.y + fyUnit) * lineScale)

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