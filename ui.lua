dialogue = nil
dialogueVisibleTimer = 0
dialogueHeight = nil
dialoguePosition = 0 -- 0 is offscreen, up to whatever height the text is
lineHeight = 6
pressedTab = nil
tabSpacing = 20

mouseSprites = { pointer = 70, open = 71, grab = 72 }
toolSprites = { seeds = 67, water = 68, fire = 69 }

tabs = {
    {
        icon = 67, onClick = function()
            if mode == "seeds" then
                mode = nil
            else
                mode = "seeds"
            end
        end
    },
    {
        icon = 68, onClick = function()
            if mode == "water" then
                mode = nil
            else
                mode = "water"
            end
        end
    },
    {
        icon = 69, onClick = function()
            if mode == "fire" then
                mode = nil
            else
                mode = "fire"
            end
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
        print(dialogue, 8, 134 - dialoguePosition, 1)
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
        if isHovering and not pressedTab then
            mouseState = "pointer"
        end
        if not isHovering then
            y -= 2
        end
        if isPressed then
            pal(7, 6)
        end

        spr(80, x - 2, y - 2)
        spr(82, x + 6, y - 2)
        spr(96, x - 2, y + 6)
        spr(98, x + 6, y + 6)
        pal()
        spr(tab.icon, x + 2, y + 2)
    end
    if pressedTab then mouseState = "grab" end
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
    mouseState = "open"
    mouseX, mouseY = stat(32), stat(33)
    mouseDown = not mouseHeld and stat(34) > 0
    -- true on the first frame the mouse is pressed
    mouseUp = mouseHeld and stat(34) == 0
    -- true on the first frame the mouse is pressed
    mouseHeld = stat(34) > 0
    -- true if the mouse button is held

    updateDialogue()
    updateButtons()
end

function drawUI()
    local mouseSprite = mouseSprites[mouseState]

    -- draw lazer
    if mode == "fire" then
        -- set the screen memory as the spritesheet
        -- and stretch screen->screen
        poke(0x5f54, 0x60)
        palt(0, false)
        local size = 10, 10
        local x, y = mouseX - 22, mouseY - 20 -- center
        sspr(
            x + size / 2, y + size / 2,
            size, size,
            x, y,
            size * 2, size * 2
        )
        poke(0x5f54, 0x00) palt() -- return to defaults
        pal(14, 0)
        if mouseHeld then
            pal(12, 8)
        end
        spr(76, x - 3, y - 3, 4, 4)
        pal()
    end

    drawDialogue()
    drawButtons()

    pal({ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 })
    if mode and mode ~= "fire" then
        spr(toolSprites[mode], mouseX - 7, mouseY - 4)
        spr(toolSprites[mode], mouseX - 6, mouseY - 3)
        spr(toolSprites[mode], mouseX - 5, mouseY - 4)
        spr(toolSprites[mode], mouseX - 6, mouseY - 5)
    end

    spr(mouseSprite, mouseX - 3, mouseY)
    spr(mouseSprite, mouseX - 2, mouseY - 1)
    spr(mouseSprite, mouseX - 2, mouseY + 1)
    spr(mouseSprite, mouseX - 1, mouseY)
    pal()
    if mode and mode ~= "fire" then
        spr(toolSprites[mode], mouseX - 6, mouseY - 4)
    end
    spr(mouseSprite, mouseX - 2, mouseY)
end