function _init()
end

function _draw()
    cls(1)
    drawDome()
    drawPeople()
    drawDialogue()
end

function _update()
    updatePeople()
    updateDialogue()
end