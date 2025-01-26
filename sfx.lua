--create all tracks here, 
--that will be requested to play from other scipts
fireTrack = createTrack(0,1,3)

function sfxUpdate()
    
    --example of requestPlay
    
    if btn(1) then
        --log("test")
        --steps:requestPlay()
        sfx(0, 1)
    elseif btn(2) then
        sfx(-2, 1)
    end
    
    
end

