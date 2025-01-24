domeRadius = 60
domeY = 88

function drawDome()
    local baseWidth = 4
    clip(0, 0, 128, domeY)
    circ(64, domeY-3, domeRadius, 7)
    clip()
    ovalfill(64 - domeRadius, domeY - domeRadius / baseWidth, 64 + domeRadius, domeY + domeRadius / baseWidth, 3)
    clip(0, domeY - 1, 128, 128)
    oval(64 - domeRadius, domeY - domeRadius / baseWidth, 64 + domeRadius, domeY + domeRadius / baseWidth, 7)
end