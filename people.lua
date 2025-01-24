--init people
nPeople = 100
peopleSpriteIndex = 2
domeAICentreX = 65
domeAICentreY = 65
domeAIRadius = 30
people = {}

for i = 1,nPeople do
    local person = {x=65, y=65} --defined inside so new people created
    add(people,person)
end

function updatePeople()

    for i = 1,#people do
        randomMove(people[i])
    end
        
end

function drawPeople()
    
    for i = 1,#people do
        spr(peopleSpriteIndex,people[i].x,people[i].y)
    end
    
end


--helpers
function randomMove(pers)
    local dir = flr(rnd(4))

    if dir == 0 then //right
        movePerson(pers, 1, 0)
    elseif dir == 1 then //down
        movePerson(pers, 0, 1)
    elseif dir == 2 then //left 
        movePerson(pers, -1, 0)
    elseif dir == 3 then //up 
        movePerson(pers, 0, -1)
    else
        --do nothing
    end
end

function movePerson(pers, xMovement, yMovement)
    local newX = pers.x + xMovement 
    local newY = pers.y + yMovement 

    if withinDome(newX, newY) then
        pers.x = newX
        pers.y = newY
    else
        --do nothing
    end
end

function withinDome(x, y)
    local diffX = x - domeAICentreX
    local diffY = y - domeAICentreY
    local dist = sqrt(diffX^2 + diffY^2)

    return dist <= domeAIRadius
end



