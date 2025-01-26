function spawnFood(x, y, z)
    local food = spawnObject(x, y, z)
    food.sprite = 1

    add(foods, food)
end