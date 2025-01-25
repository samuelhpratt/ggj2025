nPeople = 100
peopleSpeed = 1

function spawnPerson(x, y, z)
    local person = spawnObject(x, y, z)
    person.sprite = flr(rnd(2)) + 2
    person.color = flr(rnd(16))
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
        randomMove(self)

        self:updatePhysics()
    end
end

for i = 1, nPeople do
    spawnPerson(rnd(80) - 40, rnd(80) - 40, 0)
end

function updatePeople()
    for i = 1, #objects do
        if objects[i].type == "person" then
            randomMove(objects[i])
        else
            --do nothing
        end
    end
end

function randomMove(object)
    object.dx = (rnd(2) - 1) * peopleSpeed
    -- random number: -1 to 1 scaled by speed
    object.dy = (rnd(2) - 1) * peopleSpeed
    -- random number: -1 to 1 scaled by speed
end