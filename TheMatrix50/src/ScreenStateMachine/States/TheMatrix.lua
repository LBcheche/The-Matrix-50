--[[
    THE MATRIX 50

    Copyright (c) 2020
    Author: Leonardo Geo C. Bcheche
    lbcheche@gmail.com

    THE MATRIX CLASS
]]

TheMatrix = Class{__includes = BaseState}

--[[
    INITIALIZING FUCNTIONS
]]
function TheMatrix:init()

    self.matrixParams = gMatrixParams['original']

    self.matrixFX = MatrixFX(
        {
            matrixParams = self.matrixParams
        }
    )

    self.startMatrix = false

  self:initializeStartTimer()

end

function TheMatrix:initializeStartTimer()

    self.startTimer = Timer(
    {
        time = 10,
        alarmFunction = function() self.startMatrix = true end,
    })

    self.startTimer:setStart()

end

--[[
    ENTER FUCNTIONS
]]
function TheMatrix:enter(params)

end

--[[
    UPDATE FUCNTIONS
]]
function TheMatrix:update(dt)

    self.startTimer:update(dt)
 
    if self.startMatrix == true then
        self.matrixFX:update(dt)
    end

end


--[[
    RENDER FUCNTIONS
]]
function TheMatrix:render()

    self.matrixFX:render()
    --self:renderData()
 
end

-- This function is responsable for render data
-- information aboud Matrix FX
function TheMatrix:renderData()

    love.graphics.setColor(40,42,54,1)
    love.graphics.rectangle( 'fill', 5, 5, 100, 70 )

    love.graphics.setColor({self.matrixParams.rgbColor.r/255, self.matrixParams.rgbColor.g/255, self.matrixParams.rgbColor.b/255, 1})
    love.graphics.setFont(gFonts['small'].font)
    love.graphics.print(
        ' FPS: ' .. tostring(love.timer.getFPS()) ..
        '\n Font Name: ' .. tostring(self.matrixParams.fontName) .. -- 7pxkbus, 04b03, 
        '\n Font Size: '..tostring(self.matrixParams.font:getHeight()) .. ' ' ..
        '\n Font Direction: ' .. self.matrixParams.direction ..
        '\n Width In Char: ' .. tostring(self.matrixParams.widthInChar) ..
        '\n Height In Char: ' .. tostring(self.matrixParams.heightInChar) ..
        '\n Color: '.. self.matrixParams.rgbColor.name .. ' ' ..
        '\n ASCII: '.. self.matrixParams.ASCIIType ,
        5,
        5
    )

end





