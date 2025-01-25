fires = {}
smoke = {}

function spawnFire(x, y)
    local fire = spawnObject(x, y, 0)
    -- 20 sec
    fire.age = flr(rnd(400)) + 100

    function fire.draw(self)
        local x, y = self:getScreenPosition()
        spr(134 + flr(self.age / 2) % 5, x - 4, y - 7)
        pset(x, y, 3 )
    end

    function fire.update(self)
        if self.age % 4 == 0 then
            spawnSmoke(self.x + rnd(6) - 3, self.y, 6, rnd({ 0, 5 }))
        end
        for person in all(people) do
            -- simple distance check
            if (person.x - self.x) * (person.x - self.x) + (person.y - self.y) * (person.y - self.y) < 9 then
                person.burning = self.age
            end
        end
        self.age -= 1
        if self.age <= 0 then
            del(objects, self)
            del(fires, self)
        end
    end

    add(fires, fire)
end

function spawnSmoke(x, y, z, c)
    local c = c or 5
    local particle = { x = x, y = y, z = z, c = c, age = rnd(60) }
    add(smoke, particle)
end

function updateSmoke()
    local dx = sin(t()) / 10
    for particle in all(smoke) do
        particle.age -= 1
        if particle.age <= 0 then
            del(smoke, particle)
        end
        particle.z += 1
        particle.x += dx
    end

    while #smoke > 500 do
        del(smoke, smoke[1])
    end
end

function drawSmoke()
    for particle in all(smoke) do
        local x = 64 + particle.x
        local y = domeY + particle.y * domeAngle - particle.z * (1 - domeAngle)
        pset(x, y, particle.c)
    end
end