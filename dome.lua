domeRadius = 60
domeY = 88

function drawDome()
    local baseWidth = 4
    clip(0, 0, 128, domeY)
    color(7)
    circ(64, domeY-3, domeRadius)
    clip()
    color(3)
    ovalfill(64 - domeRadius, domeY - domeRadius / baseWidth, 64 + domeRadius, domeY + domeRadius / baseWidth)
    clip(0, domeY - 1, 128, 128)
    color(7)
    oval(64 - domeRadius, domeY - domeRadius / baseWidth, 64 + domeRadius, domeY + domeRadius / baseWidth)
end