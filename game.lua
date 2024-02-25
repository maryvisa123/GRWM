local Game = {}

local timer = 60
local timerColor = {0, 0, 0}
local scores = {0, 0, 0, 0}
local scoreColors = {{255, 0, 0}, {0, 255, 0}, {0, 0, 255}, {255, 255, 0}} -- Red, Green, Blue, Yellow
local bgmGame = love.audio.newSource('bgm/game_bgm.mp3', 'stream')
local bgImageGame = love.graphics.newImage('bg/game_bg.jpg')
local toteBag = {x = 0, y = 0,width = 100, height = 50, image = love.graphics.newImage('items/toteBag.png'), scale = 2}
toteBag.width = toteBag.image:getWidth() * toteBag.scale -- Update the width to account for the scaling
toteBag.height = toteBag.image:getHeight() * toteBag.scale -- Update the height to account for the scaling

-- Load your assets outside of your functions
local timerFont = love.graphics.newFont(20) -- Font for the timer

-- Item properties
local Item = {width = 50, height = 50, speed = 600}
Item.images = {
    love.graphics.newImage('items/item1.png'),
    love.graphics.newImage('items/item2.png'),
    love.graphics.newImage('items/item3.png'),
    love.graphics.newImage('items/item4.png'),
}

local items = {}

-- Reset timer and score when the game resets
function Game.reset()
    timer = 60
    scores = {0, 0, 0, 0}
end

-- Set the tote at the lower left corner 
function Game.load()
    toteBag.x = 0 
    toteBag.y = love.graphics.getHeight() - toteBag.height
end

function Game.update(dt)
    -- Countdown
    timer = timer - dt

    -- Move toteBag along x-axis with mouse
    local mouseX = love.mouse.getX()
    toteBag.x = math.max(0, math.min(love.graphics.getWidth() - toteBag.width, mouseX - toteBag.width / 2))

    -- Generate new items
    if #items < 7 and love.math.random() < dt * 0.8 then
        local newItem = {
            x = love.math.random(0, love.graphics.getWidth() - Item.width),
            y = -Item.height,
            type = love.math.random(#Item.images),
        }
        newItem.image = Item.images[newItem.type]
        table.insert(items, newItem)
    end

    -- Move items
    for i, item in ipairs(items) do
        item.y = item.y + Item.speed * dt

        -- Check for collision with toteBag
        if item.y + Item.height > love.graphics.getHeight() - toteBag.height and item.x + Item.width > toteBag.x and item.x < toteBag.x + toteBag.width then
            scores[item.type] = scores[item.type] + 10
            if scores[item.type] > 100 then
                scores[item.type] = 100
            end
            table.remove(items, i)
        elseif item.y > love.graphics.getHeight() then
            table.remove(items, i)
        end
    end
end

function Game.draw()
    -- Draw the timer
    love.graphics.setFont(timerFont)
    love.graphics.setColor(timerColor)
    love.graphics.printf('Time left: ' .. math.floor(timer), love.graphics.getWidth() - 200, 10, 200, 'right')

    -- Reset color
    love.graphics.setColor{1, 1, 1}

    -- Draw toteBag
    love.graphics.draw(toteBag.image, toteBag.x, love.graphics.getHeight() - toteBag.height, 0, toteBag.scale, toteBag.scale)

    -- Draw items
    local itemScale = 0.9 
    for _, item in ipairs(items) do
        love.graphics.draw(item.image, item.x, item.y, 0, itemScale, itemScale)
    end

    -- Draw scores and item icons
    for i, score in ipairs(scores) do
        local xOffset = 20 -- Space between each icons/bars
        local yOffset = 40 -- Space between each icons/bars
        -- Draw item icons
        local iconScale = 0.4 -- icon sizes
        love.graphics.draw(Item.images[i], 10, 5 + (i - 1) * yOffset, 0, iconScale, iconScale)
        if i == 4 then
            love.graphics.draw(Item.images[i], 20, 5 + (i - 1) * yOffset, 0, iconScale + 0.1, iconScale + 0.1)
        end
        -- Draw scoring bars
        love.graphics.setColor(scoreColors[i][1], scoreColors[i][2], scoreColors[i][3], 90/255) 
        love.graphics.rectangle('fill', 10 + Item.width * iconScale + 10 + xOffset, 15 + (i - 1) * yOffset, score * 2, 20)
        
        -- Draw white-lined rectangles around scoring bars
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle('line', 10 + Item.width * iconScale + 10 + xOffset, 15 + (i - 1) * yOffset, 200, 20)
    end
    love.graphics.setColor(1, 1, 1) -- Reset color
end

function Game.isOver()
    return timer <= 0
end

function Game.getScores()
    return scores
end

return Game