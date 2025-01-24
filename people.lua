--init people
local n = 100
people = {}

for i = 1,n do
    local person = {x=65, y=65} --defined inside so new people created
    add(people,person)
end

--helpers
function randomMove(pers)
    local dir = flr(rnd(4))

    if dir == 0 then //right
        pers.x += 1
    elseif dir == 1 then //down
        pers.y += 1
    elseif dir == 2 then //left 
        pers.x -= 1
    elseif dir == 3 then //up 
        pers.y -= 1
    else
        --do nothing
    end

    return pers
end

function updatePeople()

    for i = 1,#people do
        people[i] = randomMove(people[i])
    end
        
end

function drawPeople()
    
    for i = 1,#people do
        spr(1,people[i].x,people[i].y)
    end
    
    
end

