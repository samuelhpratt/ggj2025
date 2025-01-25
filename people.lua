nPeople = 100
peopleSpeed = 1

for i = 1,nPeople do
    spawnObject(0, 0, 0, "person")
end

function updatePeople()
    for i = 1,#objects do
        if objects[i].type == "person" then
            randomMove(objects[i])
        else
            --do nothing
        end
    end
end
    
function randomMove(object)
    object.dx = (flr(rnd(3)) - 1) * peopleSpeed -- random number: -1 to 1 scaled by speed
    object.dy = (flr(rnd(3)) - 1) * peopleSpeed -- random number: -1 to 1 scaled by speed
end
