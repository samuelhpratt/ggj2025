poke(0x5F2D, 1) -- enable mouse
music(0)

screen = "title"
offset = 0

function _init()
    cracking = 0
    blackScreen = 0
    broken = false
    cracks = {}
    shake = 0

    objects = {}
    people = {}
    selectedPerson = nil
    spawnPerson(0, 0, 0)

    fires = {}
    smoke = {}

    puddles = {}

    foods = {}

    toolCooldown = 0
    mode = nil

    started = false

    endingCountdown = 0
    endingText = nil
end

function _draw()
    cls(0)
    if screen == "title" then
        drawTitle()
    elseif screen == "game" then
        drawGame()
    end

    draw_logs()
end

function drawGame()
    cls(0)
    if blackScreen > 0 then
        return
    end

    -- screen shake
    local shakex = 1 - rnd(2)
    local shakey = 1 - rnd(2)
    shakex *= shake
    shakey *= shake
    camera(shakex, shakey)
    shake = shake * 0.5
    if (shake < 0.05) shake = 0
    drawDome()

    camera()

    drawUI()
end

function drawTitle()
    cls(0)
    camera(0, offset)
    -- draw background dither
    local bgColor = 1
    rectfill(0, 0, 128, 30, 1)
    for i = 16, 1, -1 do
        fillp(shades[i])
        local y = 27 + 3 * i
        local y1 = y
        local y2 = y + 3
        rectfill(0, y1, 128, y2, bgColor)
    end
    fillp()
    spr(192, 0, 4, 16, 4)

    if offset == 0 then
        print("press ❎ to start", 30, 90, 7)
    end
end

function _update()
    updateUI()

    if screen == "title" then
        if offset == 0 and btnp(5) then
            started = true
        end
        if started then
            offset += 4
            if offset >= 128 then
                screen = "game"
            end
        elseif offset > 0 then
            offset -= 4
        end

        if not started or offset <= 128 then
            return
        end
    elseif offset > 0 then
        offset -= 4
    end

    updateSmoke()
    updatePuddles()
    updateObjects()
    updateTracks()
    sfxUpdate()
    updateDome()
    updateWorldInfo()

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