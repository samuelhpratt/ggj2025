domeRadius = 56
domeY = 80
domeAngle = 0.5 -- multiply y values by this when drawing :)

shades = {
    0b0000000000000000,
    0b1000000000000000,
    0b1000000000100000,
    0b1010000000100000,
    0b1010000010100000,
    0b1010010010100000,
    0b1010010010100001,
    0b1010010110100001,
    0b1010010110100101,
    0b1110010110100101,
    0b1110010110110101,
    0b1111010110110101,
    0b1111010111110101,
    0b1111110111110101,
    0b1111110111110111,
    0b1111111111110111
}

function drawDome()
    domeAngle = 0.5 - (mouseY / 128) * 0.2

    domeY = 80 + offset

    -- draw background dither
    local bgColor = 1
    for i = 16, 1, -1 do
        fillp(shades[i])
        local y = 70 + 7 * i
        local y1 = domeY - 1 - y * domeAngle
        local y2 = domeY + 2 + y * domeAngle
        ovalfill(64 - y, y1, 64 + y, y2, bgColor)
    end
    fillp()

    -- draw ground
    ovalfill(62 - domeRadius, domeY - 2 - domeRadius * domeAngle, 66 + domeRadius, domeY + 2 + domeRadius * domeAngle, 8)
    ovalfill(64 - domeRadius, domeY - domeRadius * domeAngle, 64 + domeRadius, domeY + domeRadius * domeAngle, 2)

    drawPuddles()

    if broken then
        color(7)
        -- draw shards
        for crack in all(cracks) do
            line(64 - crack[1], domeY - crack[2] * domeAngle + crack[3] * (1 - domeAngle), 64 - crack[4], domeY - crack[5] * domeAngle + crack[6] * (1 - domeAngle))
            line(64 - crack[7], domeY - crack[8] * domeAngle + crack[9] * (1 - domeAngle))
            line(64 - crack[1], domeY - crack[2] * domeAngle + crack[3] * (1 - domeAngle))
        end
    end

    drawObjects()
    drawSmoke()

    if not broken then
        -- draw cracks
        color(7)
        for crack in all(cracks) do
            if #crack > 3 then
                line(64 - crack[1], domeY - crack[2] * domeAngle + crack[3] * (1 - domeAngle), 64 - crack[4], domeY - crack[5] * domeAngle + crack[6] * (1 - domeAngle))
                for i = 7, #crack, 3 do
                    line(64 - crack[i], domeY - crack[i + 1] * domeAngle + crack[i + 2] * (1 - domeAngle))
                end
            end
        end

        clip(0, domeY - 4, 128, 128)
        oval(63 - domeRadius, domeY - 1 - domeRadius * domeAngle, 65 + domeRadius, domeY + 1 + domeRadius * domeAngle, 8)
        oval(62 - domeRadius, domeY - 2 - domeRadius * domeAngle, 66 + domeRadius, domeY + 2 + domeRadius * domeAngle, 8)

        -- draw glass
        clip(0, 0, 128, domeY)
        circ(64, domeY - 3, domeRadius, 7)
        clip(0, domeY - 1, 128, 128)
        oval(64 - domeRadius, domeY - domeRadius * domeAngle, 64 + domeRadius, domeY + domeRadius * domeAngle, 7)
        clip()
    end
end

function addCrack()
    local angle = rnd(0.5) + .25
    local x, y = sin(angle) * domeRadius, cos(angle) * domeRadius
    local crack = { x, y, 1 }
    add(cracks, crack)
    shake += 1
    return crack
end

function expandCrack(crack)
    if #crack < 15 then
        -- get last pos
        local x, y = crack[#crack - 2], crack[#crack - 1]
        -- move towards center a lil bit
        local dist = sqrt(x * x + y * y)
        x -= (x / dist) * rnd(6)
        y -= (y / dist) * rnd(6)
        if #crack > 5 then
            x += rnd(8) - 4
            y += rnd(8) - 4
        end

        -- get z
        dist = sqrt(x * x + y * y)
        local z = sqrt(domeRadius * domeRadius - dist * dist)

        add(crack, x)
        add(crack, y)
        add(crack, -z)
        shake += 1
    end
end

function updateDome()
    if cracking > 0 and flr(t() * 10) % 2 == 0 then
        cracking -= 1
        if rnd() > #cracks / 12 then
            addCrack()
        elseif #cracks > 0 and rnd() > .5 then
            expandCrack(rnd(cracks))
        end
        if cracking <= 0 then
            broken = true
            mode = nil
            blackScreen = 60
            shake = 0

            -- replace cracks with glass shards on the ground
            cracks = {}
            for i = 1, 20 do
                local x, y = rnd(domeRadius * 3) - domeRadius * 1.5, rnd(domeRadius * 3) - domeRadius * 1.5
                while x * x + y * y > (domeRadius * 1.5) * (domeRadius * 1.5) do
                    x, y = rnd(domeRadius * 3) - domeRadius * 1.5, rnd(domeRadius * 3) - domeRadius * 1.5
                end
                local shard = {}
                for j = 1, 3 do
                    add(shard, x + rnd(20) - 10)
                    add(shard, y + rnd(20) - 10)
                    add(shard, rnd(3))
                end
                add(cracks, shard)
            end
        end
    end
    if blackScreen > 0 then
        blackScreen -= 1
        if blackScreen == 30 then
            --todo: smash sfx
        end

        if blackScreen == 0 then
            endingCountdown = 60
            if #people == 1 then
                endingText = "1 mikkel escaped."
            else
                endingText = #people.." mikkes escaped."
            end
        end
    end
end

function screenPosToCoords(x, y)
    x, y = x - 64, (y - domeY) / domeAngle
    if x * x + y * y >= (domeRadius - 2) * (domeRadius - 2) then
        y = sqrt((domeRadius - 2) * (domeRadius - 2) - x * x) * sgn(y)
    end
    return x, y
end