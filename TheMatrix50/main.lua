--[[
    THE MATRIX 50

    Copyright (c) 2020
    Author: Leonardo Geo C. Bcheche
    lbcheche@gmail.com

]]

require 'src/Constants'

Moonshine = require 'src/moonshine'


function love.load()

  effect = Moonshine(Moonshine.effects.dmg)--.chain(Moonshine.effects.crt)--.chain(Moonshine.effects.crt)



    -- set random number for RGB in gray scale 
    math.randomseed(os.time())

    -- initialize our nearest-neighbor filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

 
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

    effect.dmg.palette = 'gameboy_dark'
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

    
        --love.graphics.draw(backgroundImage, 0, 0)
        effect(function()gStateMachine:render()  end)
        --effect2(function()gStateMachine:render()  end)
        
       -- gStateMachine:render()
        
    push:finish()

    --love.graphics.setBackgroundColor( 25/255,  25/255, 25/255, 1)
    
end

