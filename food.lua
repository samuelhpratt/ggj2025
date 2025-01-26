function spawnFood(x, y, z)
    local food = spawnObject(x, y, z)
    food.sprite = 1
    sfx(52)
    add(foods, food)
end