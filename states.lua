
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

    for object in all(objects) do
        if object.sprite == objectSprites.person then
            if object.fire > 0 then
                peopleFires = true
            end
        end
    end

    thereIsFire = environmentFires or peopleFires
    log("env:"..tostr(#fires))

    --[[
    --food?
    for person in people do
        if person.fire > 0 then
            peopleFires = true
        end
    end
    ]]

end