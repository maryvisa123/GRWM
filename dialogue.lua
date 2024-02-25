local Dialogue = {}

local characterImage, dialogue, characterName, currentDialogue
local dialogueBoxColor = {0, 0, 0, 1}
local characterNameBoxColor = {0, 0, 0, 1}
local textColor = {1, 1, 1, 1}
local font = love.graphics.newFont(20)
local dialogueBox = {x = 50, y = love.graphics.getHeight() - 180, width = love.graphics.getWidth() - 100, height = 120}
local dialogueFinished = false

function Dialogue.reset()
    dialogueFinished = false
end

function Dialogue.load()
    characterImage = love.graphics.newImage('character/girl2.png')
    dialogue = {"Hello, I'm Sally.", 
                "Please help me, I'm going to an interview in 60 seconds and I've got nothing done yet!", 
                "What do I need to do? Right, get my makeup done, outfit sorted, hair styled and files ready!", 
                "You won't have enough time to get everything done in time, so pick and choose!"}
    characterName = "Sally"
    currentDialogue = 1
end

function Dialogue.update(dt)
    if love.keyboard.isDown('space') then
        if currentDialogue < #dialogue then
            currentDialogue = currentDialogue + 1
        else
            dialogueFinished = true
        end
    end
end

function Dialogue.draw()
    if not dialogueFinished then
        -- Half-transparent pink filling color
        local fillingColor = {1, 0.5, 0.5, 0.8}

        -- Draw dialogue box filling
        love.graphics.setColor(fillingColor)
        love.graphics.rectangle('fill', dialogueBox.x, dialogueBox.y, dialogueBox.width, dialogueBox.height)

        -- Draw dialogue box outline
        love.graphics.setColor(1, 1, 1)
        love.graphics.setLineWidth(3)
        love.graphics.rectangle('line', dialogueBox.x, dialogueBox.y, dialogueBox.width, dialogueBox.height)

        -- Draw character name box filling
        love.graphics.setColor(fillingColor)
        love.graphics.rectangle('fill', dialogueBox.x, dialogueBox.y - 30, 150, 30)

        -- Draw character name box outline
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle('line', dialogueBox.x, dialogueBox.y - 30, 150, 30)

        -- Draw character image with scaling and adjusted position
        local imageScale = 0.2 -- Change this value to control the size of the character image
        local imageWidth = characterImage:getWidth() * imageScale
        local imageHeight = characterImage:getHeight() * imageScale
        local imageX = dialogueBox.x + 340 - imageWidth
        local imageY = dialogueBox.y - imageHeight + 70

        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(characterImage, imageX, imageY, 0, imageScale, imageScale)

        -- Draw character name and dialogue text
        love.graphics.setColor(textColor)
        love.graphics.setFont(font)
        love.graphics.printf(characterName, dialogueBox.x + 10, dialogueBox.y - 25, 150, 'left')
        love.graphics.printf(dialogue[currentDialogue], dialogueBox.x + 10, dialogueBox.y + 10, dialogueBox.width - 20, 'left')
    end
end

function Dialogue.isFinished()
    return dialogueFinished
end

function Dialogue.keypressed(key, isrepeat)
    if key == 'space' then
        if currentDialogue < #dialogue then
            currentDialogue = currentDialogue + 1
        else
            dialogueFinished = true
        end
    end
end

function Dialogue.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        if currentDialogue < #dialogue then
            currentDialogue = currentDialogue + 1
        else
            dialogueFinished = true
        end
    end
end

return Dialogue