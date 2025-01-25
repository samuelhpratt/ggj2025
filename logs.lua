--basic text logging
logs = {}
logodd = false
function log(a, b, c, d, e)
    local text = a
    if (b) then text = text .. ", " .. b end
    if (c) then text = text .. ", " .. c end
    if (d) then text = text .. ", " .. d end
    if (e) then text = text .. ", " .. e end
    add(logs, {
        text = text,
        age = 60,
        odd = logodd
    })
    logodd = not logodd
    if #logs > 21 then
        del(logs, logs[1])
    end
end

function draw_logs(c1, c2)
    c1 = c1 or 7
    c2 = c2 or 6
    if (#logs > 0) then
        for i = 1, #logs do
            print(logs[i].text, 0, i * 6 - 6, 2)
            print(logs[i].text, 0, i * 6 - 5, 2)
            print(logs[i].text, 0, i * 6 - 4, 2)
            print(logs[i].text, 1, i * 6 - 6, 2)
            print(logs[i].text, 1, i * 6 - 4, 2)
            print(logs[i].text, 2, i * 6 - 6, 2)
            print(logs[i].text, 2, i * 6 - 5, 2)
            print(logs[i].text, 2, i * 6 - 4, 2)
            print(logs[i].text, 1, i * 6 - 5, logs[i].odd and c2 or c1)
            logs[i].age -= 1
        end
    end
    for log in all(logs) do
        if log.age < 0 then
            del(logs, log)
        end
    end
end