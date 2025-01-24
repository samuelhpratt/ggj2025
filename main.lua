function _init()

    //init people
    people = {} //global
    

    --people = {{x=10, y=15}, {x=20, y=30}, {x=25, y=35}}
    
    for i = 1,100 do
        local person = {x=65, y=65}
        add(people,person)
    end
    

end


function random_move(pers)
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


function _update()

    for i = 1,#people do
        people[i] = random_move(people[i])
    end




        
end

function _draw()
    --[[
    cls()
    spr(1,10,30)
    spr(1,15,45)
    ]]

    
    cls()
    for i = 1,#people do
        spr(1,people[i].x,people[i].y)
    end
    
    
end

