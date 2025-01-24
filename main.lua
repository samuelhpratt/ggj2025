function _init()
end

function _draw()
    cls(1)
    drawDome()
    drawPeople()
    drawObjects()
    drawUI()
    pset(mouseX, mouseY, 7)
end

function _update()
    mouseX, mouseY = stat(32), stat(33)
    mouseDown = not mouseHeld and stat(34) > 0 -- true on the first frame the mouse is pressed
    mouseUp = mouseHeld and stat(34) == 0 -- true on the first frame the mouse is pressed
    mouseHeld = stat(34) > 0 -- true if the mouse button is held
    
    updatePeople()
    updateObjects()
    updateUI()
end