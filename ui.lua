dialogue = nil
dialogueVisibleTimer = 0
dialogueHeight = nil
dialoguePosition = 0 -- 0 is offscreen, up to whatever height the text is
lineHeight = 6
pressedTab = nil
tabSpacing = 20

tabs = {
    {
        icon = 67, onClick = function()
            mode = "food"
            showNewDialogue("test message")
        end
    },
    {
        icon = 68, onClick = function()
            mode = "water"
            showNewDialogue("test message...\nwith a second line!!")
        end
    },
    {
        icon = 69, onClick = function()
            mode = "fire"
            showNewDialogue("test message...\nwith a second line......\nand a third line???")
        end
    }
}

function drawDialogue()
    if dialogue then
        for y = 0, ceil(dialogueHeight / 8) do
            for x = 0, 15 do
                local spriteNumber = y == 0 and 65 or 81
                if x == 0 then
                    spriteNumber -= 1
                elseif x == 15 then
                    spriteNumber += 1
                end
                spr(spriteNumber, x * 8, y * 8 + 130 - dialoguePosition)
            end
        end
        print(dialogue, 8, 134 - dialoguePosition,1)
    end
end

function updateDialogue()
    if dialogue == nil then
        return
    end

    if dialogueVisibleTimer > 0 then
        if dialoguePosition < dialogueHeight then
            dialoguePosition += 3
        else
            dialogueVisibleTimer -= 1
        end
    elseif dialoguePosition > 0 then
        dialoguePosition -= 3
        if dialoguePosition == 0 then
            dialogue = {}
        end
    end
end

function showNewDialogue(text)
    dialogue = text
    dialoguePosition = 0
    dialogueVisibleTimer = 60
    local w, h = print(dialogue, 999, 0)
    dialogueHeight = h + 6
end

function drawButtons()
    for i, tab in ipairs(tabs) do
        local x, y = 64 - (#tabs * tabSpacing * 0.5) + (i - 1) * tabSpacing, -1
        local isHovering = mouseX >= x and mouseY >= y and mouseX <= x + 12 and mouseY <= y + 12
        local isPressed = tab == pressedTab
        if not isHovering then
            y-=2
        end
        -- if isPressed then
        --     color = 5
        -- end

        spr(80, x - 2, y - 2)
        spr(82, x + 6, y - 2)
        spr(96, x - 2, y + 6)
        spr(98, x + 6, y + 6)
        spr(tab.icon, x + 2, y + 2)
    end
end

function updateButtons()
    -- check for mouse click interactions
    for i, tab in ipairs(tabs) do
        local x, y = 64 - (#tabs * tabSpacing * 0.5) + (i - 1) * tabSpacing, -1
        local isSelected = mouseX >= x and mouseY >= y and mouseX <= x + 12 and mouseY <= y + 12
        
        if mouseDown and isSelected then
            pressedTab = tab
        end

        if mouseUp and isSelected and pressedTab == tab then
            tab.onClick()
        end
    end

    if mouseUp then
        pressedTab = nil
    end
end

function updateUI()
    updateDialogue()
    updateButtons()
end

function drawUI()
    drawDialogue()
    drawButtons()
end