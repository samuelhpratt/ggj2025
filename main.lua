poke(0x5F2D, 1) -- enable mouse
mode = nil

function _init()
end

function _draw()
    drawDome()
    drawObjects()
    drawSmoke()
    drawUI()
    local mouseSprite
    if mouseHeld then
        mouseSprite = 72
    else
        mouseSprite = 70
    end
    pal({ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 })
    spr(mouseSprite, mouseX - 3, mouseY)
    spr(mouseSprite, mouseX - 2, mouseY - 1)
    spr(mouseSprite, mouseX - 2, mouseY + 1)
    spr(mouseSprite, mouseX - 1, mouseY)
    pal()
    spr(mouseSprite, mouseX - 2, mouseY)
    updateStates()
    draw_logs()
    drawLines()
end

function _update()
    mouseX, mouseY = stat(32), stat(33)
    mouseDown = not mouseHeld and stat(34) > 0
    -- true on the first frame the mouse is pressed
    mouseUp = mouseHeld and stat(34) == 0
    -- true on the first frame the mouse is pressed
    mouseHeld = stat(34) > 0
    -- true if the mouse button is held

    if mouseHeld and mode then
        local x, y = screenPosToCoords(mouseX, mouseY)
        if mode == "food" then
                x += rnd(2) - 1
                y += rnd(2) - 1
                spawnFood(x, y, domeRadius - sqrt(x * x + y * y) / 2)
        elseif mode == "water" then
                x += rnd(10) - 5
                y += rnd(10) - 5
                spawnDroplet(x, y, domeRadius - sqrt(x * x + y * y) / 2)
        elseif mode == "fire" then
                x += rnd(4) - 2
                y += rnd(4) - 2
                spawnFire(x, y)
        end
    end
    updateSmoke()
    updatePuddles()
    updateObjects()
    updateUI()
end