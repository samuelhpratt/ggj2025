dialogue = {}
dialogueVisibleTimer = 0
dialogueHeight = nil
dialoguePosition = 0 -- 0 is offscreen, up to whatever height the text is
lineHeight = 6

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
    dialogueVisibleTimer = 60
end