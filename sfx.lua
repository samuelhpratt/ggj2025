glassPlaying = false
sT = 0

function glassSFX()
    -- log(sT)
    if (sT == 1) and (not glassPlaying) then
        sfx(2)
        glassPlaying = true
    elseif sT == 15 then
        sT = 0
        glassPlaying = false
    end  
    sT += 1
end