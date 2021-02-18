--[[
    THE MATRIX 50

    Copyright (c) 2020
    Author: Leonardo Geo C. Bcheche
    lbcheche@gmail.com

]]

require 'src/Constants'

Moonshine = require 'src/moonshine'


function love.load()

    effect = Moonshine(Moonshine.effects.godsray)--.chain(Moonshine.effects.dmg)
    -- effect.glow.strength = 1
    -- effect.glow.min_luma = 0.1
    -- effect.boxblur.radius_x = 5
    -- effect.boxblur.radius_y = 5
    -- effect.dmg.palette = dark_yellow

    -- set random number for RGB in gray scale 
    math.randomseed(os.time())

    -- initialize our nearest-neighbor filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- app window title
    -- love.window.setTitle('The Matrix 50')
    -- love.window.setFullscreen( true )
    -- love.window.maximize()
    -- initialize our virtual resolution
 
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- initialize state machine with all state-returning functions
    gStateMachine = StateMachine {
        ['theMatrix'] = function() return TheMatrix() end,
    }
    
    gStateMachine:change('theMatrix')

    love.keyboard.keysPressed = {}

end



function love.update(dt)
    
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end


function love.resize(w, h)
    push:resize(w, h)
end


function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

 --   love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)

    return love.keyboard.keysPressed[key]

end

function love.draw()
    --gStateMachine:render()
    push:start()
    effect(function()
     gStateMachine:render() 
    end)
   -- gStateMachine:render()

    push:finish()

    
    
end

