dialogue = {}
dialogueVisibleTimer = 0
dialogueHeight = nil
dialoguePosition = 0 -- 0 is offscreen, up to whatever height the text is
lineHeight = 6
pressedButton = nil

buttons = {
    {
        x = 2, y = 0, w = 10, h = 8, onClick = function()
            spawnObject(rnd(50) - 25, rnd(50) - 25, 50, "food")
        end
    },
    {
        x = 30, y = 0, w = 10, h = 8, onClick = function()
            showNewDialogue("button 2 pressed!")
        end
    }
}

function drawDialogue()
    rectfill(0, 128 - dialoguePosition, 128, 128, 6)
    for i, line in ipairs(dialogue) do
        print(line, 2, 130 - dialoguePosition + (i - 1) * lineHeight, 0)
    end
end

function updateDialogue()
    if #dialogue == 0 then
        return
    end

    if dialogueVisibleTimer > 0 then
        if dialoguePosition < #dialogue * lineHeight + 3 then
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

function showNewDialogue(line1, line2)
    dialogue = { line1 }
    if line2 then
        add(dialogue, line2)
    end
    dialoguePosition = 0
    dialogueVisibleTimer = 40
end

function drawButtons()
    for button in all(buttons) do
        local isHovering = mouseX >= button.x and mouseY >= button.y and mouseX <= button.x + button.w and mouseY <= button.y + button.h
        local isPressed = button == pressedButton
        local color = 13
        if isHovering then
            color = 6
        end
        if isPressed then
            color = 5
        end
        rectfill(button.x, button.y, button.x + button.w, button.y + button.h, color)
    end
end

function updateButtons()
    -- check for mouse click interactions
    for button in all(buttons) do
        local isSelected = mouseX >= button.x and mouseY >= button.y and mouseX <= button.x + button.w and mouseY <= button.y + button.h

        if mouseDown and isSelected then
            pressedButton = button
        end

        if mouseUp and isSelected and pressedButton == button then
            button.onClick()
        end
    end

    if mouseUp then
        pressedButton = nil
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