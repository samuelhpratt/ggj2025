
thereIsFire = false
thereIsFood = false

function updateStates()


    updateWorldInfo()


end

function updateWorldInfo()

    --fire?
    --environment fires y/n
    local environmentFires = #fires > 0

    --people fires y/n
    local peopleFires = false

    for person in all(people) do
        if person.burning > 0 then
            peopleFires = true
        end
    end

    thereIsFire = environmentFires or peopleFires

    --log("env:"..tostr(environmentFires).." pers:"..tostr(peopleFires))

    
    --food?
    thereIsFood = #foods > 0
    --log("foods:"..tostr(thereIsFood))


end