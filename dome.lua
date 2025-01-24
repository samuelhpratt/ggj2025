domeRadius = 60
domeY = 88
domeAngle = 0.25 -- multiply y values by this when drawing :)

function drawDome()
    clip(0, 0, 128, domeY)
    circ(64, domeY-3, domeRadius, 7)
    clip()
    ovalfill(64 - domeRadius, domeY - domeRadius * domeAngle, 64 + domeRadius, domeY + domeRadius * domeAngle, 3)
    clip(0, domeY - 1, 128, 128)
    oval(64 - domeRadius, domeY - domeRadius * domeAngle, 64 + domeRadius, domeY + domeRadius * domeAngle, 7)
    clip()
end