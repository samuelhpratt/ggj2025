domeRadius = 60
domeY = 80
domeAngle = 0.5 -- multiply y values by this when drawing :)

ground = {}
groundTileW = 2
groundTileH = 5
groundW = flr(domeRadius / groundTileW)
groundH = flr(domeRadius / groundTileH)

for i = -groundW, groundW do
    ground[i] = {}
    for j = -groundH, groundH do
        ground[i][j] = rnd({3,4,12,5})
    end
end

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
    domeAngle = 0.6 -(mouseY / 128) * 0.3

    cls(0)
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
    ovalfill(64 - domeRadius, domeY - domeRadius * domeAngle, 64 + domeRadius, domeY + domeRadius * domeAngle, 2)

    drawPuddles()

    -- draw glass
    clip(0, 0, 128, domeY)
    circ(64, domeY - 3, domeRadius, 7)
    clip(0, domeY - 1, 128, 128)
    oval(64 - domeRadius, domeY - domeRadius * domeAngle, 64 + domeRadius, domeY + domeRadius * domeAngle, 7)
    clip()
end

function screenPosToCoords(x, y)
    x, y = x - 64, (y - domeY) / domeAngle
    if x * x + y * y >= (domeRadius - 2) * (domeRadius - 2) then
        y = sqrt((domeRadius - 2) * (domeRadius - 2) - x * x) * sgn(y)
    end
    return x, y
end