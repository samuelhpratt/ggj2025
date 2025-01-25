foods = {}

function spawnFood(x, y, z)
    local food = spawnObject(x, y, z)
    food.sprite = 1
    -- add any other person-specific parameters here!

    function food.update(self)
        -- add specific update logic here
        
        self:updatePhysics()
    end

    add(foods, food)
end