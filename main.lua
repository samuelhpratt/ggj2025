function _init()
end

function _draw()
    drawDome()
    drawObjects()
    drawUI()
    local mouseSprite
    if mouseHeld then
        mouseSprite = 72
    else
        mouseSprite = 70
    end
    pal({0,0,0,0,0,0,0,0,0,0,0,0,0,0})
    spr(mouseSprite, mouseX-3, mouseY)
    spr(mouseSprite, mouseX-2, mouseY-1)
    spr(mouseSprite, mouseX-2, mouseY+1)
    spr(mouseSprite, mouseX-1, mouseY)
    pal()
    spr(mouseSprite, mouseX-2, mouseY)
    draw_logs()
    drawLines()
end

function _update()
    mouseX, mouseY = stat(32), stat(33)
    mouseDown = not mouseHeld and stat(34) > 0 -- true on the first frame the mouse is pressed
    mouseUp = mouseHeld and stat(34) == 0 -- true on the first frame the mouse is pressed
    mouseHeld = stat(34) > 0 -- true if the mouse button is held
    --updatePeople()
    updateObjects()
    updateUI()
end