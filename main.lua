poke(0x5F2D, 1) -- enable mouse
mode = nil
toolCooldown = 0

function _init()
end

function _draw()
    drawDome()
    drawObjects()
    drawSmoke()
    drawUI()
    updateStates()
    draw_logs()
    drawLines()
end

function _update()
    updateUI()
    updateSmoke()
    updatePuddles()
    updateObjects()
    if mouseDown then
        toolCooldown = 0
    end
    if mouseHeld and not pressedTab and mode and mouseX > 64 - domeRadius and mouseX < 64 + domeRadius and mouseY > domeY - domeRadius and mouseY < domeY + domeRadius * domeAngle then
        local x, y = screenPosToCoords(mouseX, mouseY + 30)
        local z = 30
        if toolCooldown > 0 then
            toolCooldown -= 1
        else
            if mode == "seeds" then
                x += rnd(2) - 1
                y += rnd(2) - 1
                spawnObject(x, y, z, 1)
                toolCooldown = 4
            elseif mode == "water" then
                x += rnd(10) - 5
                y += rnd(10) - 5
                spawnDroplet(x, y, z)
            elseif mode == "fire" then
                x += rnd(4) - 2
                y += rnd(4) - 2
                spawnFire(x, y)
            end
        end
    end
end