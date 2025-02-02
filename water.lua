function spawnDroplet(x, y, z)
    local droplet = spawnObject(x, y, z)
    sfx(53)

    function droplet.draw(self)
        local x, y = self:getScreenPosition()
        if self.animation then
            -- draw animation frames
            spr(131 + self.animation, x - 3, y - 7)
        else
            pset(x, y, 6)
            pset(x, y - 1, 6)
        end
    end

    function droplet.update(self)
        if self.animation then
            self.animation += 1
            if self.animation == 3 then
                -- check if we are near any puddles
                local puddle = nil
                for p in all(puddles) do
                    if (self.x - p.x) * (self.x - p.x)
                            + (self.y - p.y) * (self.y - p.y)
                            <= (p.r + 3) * (p.r + 3) then
                        puddle = p
                        break
                    end
                end
                if puddle then
                    puddle.r += 1 / max(puddle.r / 3, 0.5)

                    for fire in all(fires) do
                        if (fire.x - puddle.x) * (fire.x - puddle.x)
                                + (fire.y - puddle.y) * (fire.y - puddle.y)
                                < puddle.r * puddle.r then
                            fire.age -= 100

                            spawnSmoke(fire.x + rnd(6) - 3, fire.y, 6, 6)
                            sfx(57)

                            -- delete self
                            del(objects, self)
                        end
                    end

                    -- check if puddle needs to move etc
                    for otherPuddle in all(puddles) do
                        if otherPuddle ~= puddle then
                            local dist = sqrt((puddle.x - otherPuddle.x) * (puddle.x - otherPuddle.x)
                                    + (puddle.y - otherPuddle.y) * (puddle.y - otherPuddle.y))

                            if puddle.r >= dist + otherPuddle.r then
                                del(puddles, otherPuddle)
                            end
                        end
                    end

                    if domeRadius < puddle.r then
                        puddle.r = domeRadius
                        -- todo: increase depth and fill dome?
                    end
                    -- check if puddle fits in the dome
                    local dist = sqrt(puddle.x * puddle.x + puddle.y * puddle.y)

                    if domeRadius < dist + puddle.r then
                        local newDist = domeRadius - puddle.r
                        puddle.x *= newDist / dist
                        puddle.y *= newDist / dist
                    end
                else
                    -- create new puddle if one doesn't exist
                    spawnPuddle(self.x, self.y)
                end
                -- delete self
                del(objects, self)
            end
        else
            self:updatePhysics()
            if self.z == 0 then
                -- landed on ground
                for fire in all(fires) do
                    if (fire.x - self.x) * (fire.x - self.x)
                            + (fire.y - self.y) * (fire.y - self.y)
                            < 25 then
                        fire.age -= 100

                        spawnSmoke(fire.x + rnd(6) - 3, fire.y, 6, 6)
                        sfx(57)
                        -- delete self
                        del(objects, self)
                        return
                    end
                end

                for person in all(people) do
                    if person.burning > 0
                            and ((person.x - self.x) * (person.x - self.x)
                                + (person.y - self.y) * (person.y - self.y))
                            < 25 then
                        person.burning -= 100

                        spawnSmoke(person.x + rnd(6) - 3, person.y, 12, 6)
                        sfx(57)
                        -- delete self
                        del(objects, self)
                        return
                    end
                end

                sfx(53)

                self.animation = 0
            end
        end
    end
end

function spawnPuddle(x, y)
    local puddle = spawnObject(x, y, 0)
    puddle.r = 1
    -- remove from objects since we want to draw them seperately
    del(objects, puddle)
    add(puddles, puddle)
end

function drawPuddles()
    for puddle in all(puddles) do
        local x, y = puddle:getScreenPosition()
        x = flr(x + 0.5)
        y = flr(y + 0.5)
        local width = puddle.r - 2

        if width >= 1 then
            ovalfill(x - width, y - width * domeAngle, x + width, y + width * domeAngle, 13)
        end
    end
end

function updatePuddles()
    for puddle in all(puddles) do
        puddle.r -= 0.005
        if puddle.r < 0 then
            del(puddles, puddle)
        end
    end
end