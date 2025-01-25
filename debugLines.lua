--basic debug lines
lines = {}

function debugLine(a, b, c, d)
    add(lines,{x0=a,y0=b,x1=c,y1=d})
end

function drawLines()
    if #lines > 0 then
        for l in all(lines) do
            --based off the perspective code in objects.lua
            --return 64 + self.x, domeY + self.y * domeAngle - self.z * (1 - domeAngle)
            line(64 + l.x0, domeY + l.y0 * domeAngle, 64 + l.x1, domeY + l.y1 * domeAngle, 8)
            --line(64 + l.x0, domeY + l.y0, 64 + l.x1, domeY + l.y1, 8)
        end
    end
    lines = {}
end