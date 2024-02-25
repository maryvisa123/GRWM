local GameOver = {}

local titleFont = love.graphics.newFont('fonts/VintageOne.ttf', 60)
local feedbackFont = love.graphics.newFont('fonts/DK Harimau.otf', 24) 
local restartButton = love.graphics.newImage('buttons/restart.png')
local quitButton = love.graphics.newImage('buttons/quit.png')

function GameOver.load()
end

function GameOver.draw(scores)
    -- Draw filler
    love.graphics.setColor(1, 0.5, 0.5, 0.8)
    love.graphics.rectangle('fill', love.graphics.getWidth() / 8, love.graphics.getHeight() / 8, love.graphics.getWidth() * 3/4, love.graphics.getHeight() * 3/4)

    -- Draw white lines
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('line', love.graphics.getWidth() / 8, love.graphics.getHeight() / 8, love.graphics.getWidth() * 3/4, love.graphics.getHeight() * 3/4)
  
    -- Reset color
    love.graphics.setColor(1, 1, 1)

    -- Print game over title
    love.graphics.setFont(titleFont)
    love.graphics.printf("Time's up!", 0, love.graphics.getHeight() / 4, love.graphics.getWidth(), 'center')

    -- Print game results
    love.graphics.setFont(feedbackFont) 
    love.graphics.draw(restartButton, love.graphics.getWidth() / 2 - restartButton:getWidth() - 20, love.graphics.getHeight() / 2 + 100)
    love.graphics.draw(quitButton, love.graphics.getWidth() / 2 + 15, love.graphics.getHeight() / 2 + 100)
    
    -- Feedback strings for each score range
    local feedback = {
        { "In a hurry, your hair looks miserable.", "Your hairstyle looks great!", "Your hair is absolutely gorgeous." },
        { "It looks like you buttoned up incorrectly today.", "You just picked your killing outfit!", "That outfit ensemble is perfect!" },
        { "Something is definitely wrong with your eyeshadow.", "Right kind of rogue for your lips", "Your makeup is impeccable" },
        { "Pretty sure you left some pages at home.", "You only left a page or two at home", "You didn't leave anything important at home!" }
    }
    
    for i, score in ipairs(scores) do
        local resultText = ""

        -- Set the color based on the score
        if score < 50 then
            love.graphics.setColor(0.8, 0.2, 0.2) -- Red for low scores
            resultText = feedback[i][1]
        elseif score < 90 then
            love.graphics.setColor(0.8, 0.8, 0.2) -- Yellow for medium scores
            resultText = feedback[i][2]
        else
            love.graphics.setColor(0.2, 0.8, 0.2) -- Green for high scores
            resultText = feedback[i][3]
        end

        love.graphics.print(resultText, love.graphics.getWidth() / 3 - 100, love.graphics.getHeight() / 2 + 30 * i - 100)
    end
    
    -- Reset color
    love.graphics.setColor(1, 1, 1)
end

return GameOver