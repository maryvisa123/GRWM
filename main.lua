local Dialogue = require 'dialogue'
local Game = require 'game'
local GameOver = require 'gameover'

-- Loading assets
local titleFont = love.graphics.newFont('fonts/Phantom.ttf', 80)
local buttonFont = love.graphics.newFont('fonts/Freedom-10eM.ttf', 20)
local bgImage = love.graphics.newImage('bg/start_bg.png')
local bgImageDialogue = love.graphics.newImage('bg/dialogue_bg.jpg')
local bgImageGame = love.graphics.newImage('bg/game_bg.jpg')
local bgm = love.audio.newSource('bgm/start_screen_bgm.mp3', 'stream')
local bgmDialogue = love.audio.newSource('bgm/dialogue_bgm.mp3', 'stream')
local bgmGame = love.audio.newSource('bgm/game_bgm.mp3', 'stream')
local startButtonImage = love.graphics.newImage('buttons/play.png')
local restartButton = love.graphics.newImage('buttons/restart.png')
local quitButton = love.graphics.newImage('buttons/quit.png')
local bgImageStart = love.graphics.newImage('bg/start_bg.png')

local gameState = "start"

function love.load()
    bgm:setLooping(true)
    love.audio.play(bgm)

    Dialogue.load()
    Game.load()
    GameOver.load()
end

-- Game state control
function love.update(dt)
    if gameState == "start" then
    elseif gameState == "dialogue" then
        Dialogue.update(dt)
        if Dialogue.isFinished() then
            gameState = "gameplay"
            love.audio.stop(bgmDialogue)
            love.audio.play(bgmGame)
            bgImage = bgImageGame
        end
    elseif gameState == "gameplay" then
        Game.update(dt)
        if Game.isOver() then
            gameState = "gameover"
            love.audio.stop(bgmGame)
        end
    elseif gameState == "gameover" then
    end
end

function love.draw()
    -- Calculate the scale factors
    local scaleX = love.graphics.getWidth() / bgImage:getWidth()
    local scaleY = love.graphics.getHeight() / bgImage:getHeight()

    -- Draw the full-screen background image, scaled to fill the window
    love.graphics.draw(bgImage, 0, 0, 0, scaleX, scaleY)

    if gameState == "start" then
        --Draw title
        love.graphics.setColor(179/255, 70/255, 165/255)
        love.graphics.setFont(titleFont)
        love.graphics.printf('GRWM', 0, love.graphics.getHeight() / 3 - 50, love.graphics.getWidth(), 'center')

        -- Draw the start button image instead of the rectangle
        love.graphics.setColor(1, 1, 1) -- Reset color to white
        love.graphics.draw(startButtonImage, love.graphics.getWidth() / 2 - startButtonImage:getWidth() / 2, love.graphics.getHeight() / 2 + 30)
    elseif gameState == "dialogue" then
        Dialogue.draw()
    elseif gameState == "gameplay" then
        Game.draw()
    elseif gameState == "gameover" then
        GameOver.draw(Game.getScores())
    end
end

function love.keypressed(key, isrepeat)
    if gameState == "dialogue" then
        Dialogue.keypressed(key, isrepeat)
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if gameState == "start" then
        -- Check if the Start button image is clicked
        if button == 1 and
        x > love.graphics.getWidth() / 2 - startButtonImage:getWidth() / 2 and x < love.graphics.getWidth() / 2 + startButtonImage:getWidth() / 2 and
        y > (love.graphics.getHeight() / 2 + 30) and y < (love.graphics.getHeight() / 2 + 30 + startButtonImage:getHeight()) then
            gameState = "dialogue"
            love.audio.stop(bgm)
            love.audio.play(bgmDialogue)
            bgImage = bgImageDialogue
            Dialogue.load()
        end
    elseif gameState == "dialogue" then
        Dialogue.mousepressed(x, y, button, istouch, presses)
    elseif gameState == "gameover" then
        if button == 1 then
            local buttonWidth = restartButton:getWidth()
            local buttonHeight = restartButton:getHeight()
            
            -- Check if the Restart button is clicked
            if x > love.graphics.getWidth() / 2 - restartButton:getWidth() - 20 and x < love.graphics.getWidth() / 2 - 20
            and y > love.graphics.getHeight() / 2 + 100 and y < love.graphics.getHeight() / 2 + 100 + restartButton:getHeight() then
                Game.reset()
                Dialogue.reset()
                gameState = "start"
                love.audio.play(bgm)
                bgImage = bgImageStart
                Dialogue.load()
                Game.load()
                GameOver.load()
            end
            
            -- Check if the Quit button is clicked
            if x > love.graphics.getWidth() / 2 + 15 and x < love.graphics.getWidth() / 2 + 15 + quitButton:getWidth()
            and y > love.graphics.getHeight() / 2 + 100 and y < love.graphics.getHeight() / 2 + 100 + quitButton:getHeight() then
                love.event.quit()
            end
        end
    end
end