fires = {}

function spawnFire(x, y)
    local fire = spawnObject(x, y, 0)
    fire.age = 600  -- 20 sec

    function fire.draw(self)
        local x, y = self:getScreenPosition()
        spr(134 + flr(self.age / 2) % 5, x - 4, y - 7)
    end

    function fire.update(self)
        for person in all(people) do
            -- simple distance check
            if (person.x - self.x) * (person.x - self.x) + (person.y - self.y) * (person.y - self.y) < 9 then
                person.burning += 10
            end
        end
        self.age -= 1
        if self.age <= 0 then
            del(objects, self)
        end
    end

    add(fires, fire)
end