thereIsFire = false
thereIsFood = false

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

    if thereIsFire then
        --fireTrack:requestPlay()
    end

    --log("env:"..tostr(environmentFires).." pers:"..tostr(peopleFires))

    --food?
    thereIsFood = #foods > 0
    --log("foods:"..tostr(thereIsFood))

    if #people == 0 and not endingText then
        music(-1)
        endingCountdown = 120
        mode = nil
        endingText = "no mikkels remain."
    end

    if #people > 32 and cracking == 0 and not broken then
        music(-1)
        cracking = 120
    end
end