poke(0x5F2D, 1) -- enable mouse
music(0)

function _init()
    cracking = 0
    blackScreen = 0
    broken = false
    cracks = {}
    
    toolCooldown = 0
    mode = nil
end

function _draw()
    cls(0)
    if blackScreen > 0 then
        return
    end
    drawDome()
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
    updateDome()
    if mouseDown then
        toolCooldown = 0
    end

    if not mouseHeld and mode == "fire" and mouseX > 80 - domeRadius and mouseX < 80 + domeRadius and mouseY - 16 > domeY - domeRadius and mouseY - 16 < domeY + domeRadius * domeAngle then
        local x, y = screenPosToCoords(mouseX - 12, mouseY - 5)
        -- find person being looked at
        local closestDist = 81
        local closest = nil
        for person in all(people) do
            local dist = (person.x - x) * (person.x - x) + (person.y - y) * (person.y - y)
            if dist < closestDist then
                closest = person
                closestDist = dist
            end
        end
        if closest ~= selectedPerson and selectedPerson ~= nil then
            selectedPerson = nil
        else
            selectedPerson = closest
        end
    else
        selectedPerson = nil
    end

    if mouseHeld and not pressedTab and mode then
        local z = 30 + rnd(5)
        if toolCooldown > 0 then
            toolCooldown -= 1
        else
            if mode == "seeds" and mouseX > 72 - domeRadius and mouseX < 72 + domeRadius and mouseY + 40 * (1 - domeAngle) > domeY - domeRadius and mouseY + 40 * (1 - domeAngle) < domeY + domeRadius * domeAngle then
                local x, y = screenPosToCoords(mouseX - 10, mouseY + 50 * (1 - domeAngle))
                x += rnd(2) - 1
                y += rnd(2) - 1
                spawnFood(x, y, z)
                toolCooldown = 4
            elseif mode == "water" and mouseX > 84 - domeRadius and mouseX < 84 + domeRadius and mouseY + 40 > domeY - domeRadius and mouseY + 40 < domeY + domeRadius * domeAngle then
                local x, y = screenPosToCoords(mouseX - 20, mouseY + 46)
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