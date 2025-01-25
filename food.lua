foods = {}

function spawnFood(x, y, z)
    local food = spawnObject(x, y, z)
    food.sprite = 1
    -- add any other person-specific parameters here!

    function food.update(self)
        if self.z == 0 then
            -- add specific update logic here
            for person in all(people) do
                -- simple distance check
                if (person.x - self.x) * (person.x - self.x) + (person.y - self.y) * (person.y - self.y) < 25 then
                    person.happiness += 1
                    -- log(person.happiness)
                    del(objects, self)
                    del(foods, self)
                end
            end
        end

        self:updatePhysics()
    end

    add(foods, food)
end