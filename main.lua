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
    updateWorldInfo()
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
    if mouseHeld and not pressedTab and mode then
        local x, y = screenPosToCoords(mouseX, mouseY + 30)
        local z = 30
        if toolCooldown > 0 then
            toolCooldown -= 1
        else
            if mode == "seeds" and mouseX > 64 - domeRadius and mouseX < 64 + domeRadius and mouseY > domeY - domeRadius and mouseY < domeY + domeRadius * domeAngle then
                x += rnd(2) - 1
                y += rnd(2) - 1
                spawnFood(x, y, z)
                toolCooldown = 4
            elseif mode == "water" and mouseX > 64 - domeRadius and mouseX < 64 + domeRadius and mouseY > domeY - domeRadius and mouseY < domeY + domeRadius * domeAngle then
                x += rnd(10) - 5
                y += rnd(10) - 5
                spawnDroplet(x, y, z)
            elseif mode == "fire" and mouseX > 80 - domeRadius and mouseX < 80 + domeRadius and mouseY - 16 > domeY - domeRadius and mouseY - 16 < domeY + domeRadius * domeAngle then
                local x, y = screenPosToCoords(mouseX - 12, mouseY - 6)
                x += rnd(2) - 1
                y += rnd(2) - 1
                -- check for puddles first
                local hitPuddle = false
                for puddle in all(puddles) do
                    if (x - puddle.x) * (x - puddle.x)
                            + (y - puddle.y) * (y - puddle.y)
                            < (puddle.r + 2) * (puddle.r + 2) then
                        puddle.r -= 0.05

                        spawnSmoke(x + rnd(6) - 3, y, 6, 6)
                        hitPuddle = true
                        break
                    end
                end
                if not hitPuddle then
                    spawnFire(x, y)
                end
            end
        end
    end
end