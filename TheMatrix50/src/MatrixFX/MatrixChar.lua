--[[
    THE MATRIX 50

    Copyright (c) 2020
    Author: Leonardo Geo C. Bcheche
    lbcheche@gmail.com

    Matrix Char Class

]]

MatrixChar = Class{}

--[[
    INITIAL FUNCTIONS
]]
function MatrixChar:init(params)

    self.font = params.font -- char's codeline font
    self.x = params.x -- char's x position
    self.y = params.y -- char's y position
    self.changingTime = params.changingTime -- frequency to change the char's letter and color
    self.RGBColor = params.rgbColor -- table that represents a color of char's font:  {r = , g= , b= }
    self.colorVariation = params.colorVariation -- color range for saturation and lightness in %
    self.ASCIICodes = params.ASCIICodes -- list of tables that represents possible chars for a Matrix Char
    -- Example for ASCIICode table {{min = , max = },{min = , max = },{min = , max = },  }
    self.movableBackground = params.movableBackground or nil
    self.movableBackgroundIndex = params.movableBackgroundIndex or nil

    self.direction = params.direction or 'left' -- char's writing direction. Can be 'right' or 'left'

    self.codeLine = params.codeLinev

 

    self.initialAlphaSetup = params.initialAlphaSetup--255
    self.middleAlphaSetup = params.middleAlphaSetup--150
    self.finalAlphaSetup = params.finalAlphaSetup-- 0
    self.remotionFadeOffSpeed = params.remotionFadeOffSpeed
    self.defaultFadeOffSpeed = params.defaultFadeOffSpeed
    self.defaultFadeOffDelay = params.defaultFadeOffDelay

    self:initializeChangingTimer()
    --self:setASCIICodes()

    self:chooseRandomChar()
    self:setStartColor()

    self.changingTimer:setStart()
   -- self.alphaSetup = 255
    self.alpha = self.initialAlphaSetup

    self.endOfChar = false

    

    self:initializeDefaultFadeOffDelayTimer()
    self:initializeDefaultFadeOff()
    self:initializeRemotionFadeOff()
    
    

end

function MatrixChar:initializeRemotionFadeOff()

    self.remotionFadeOff = FadeEffect(
        {
            alpha = self.alpha,
            initialAlpha = self.middleAlphaSetup,
            finalAlpha = self.finalAlphaSetup,
            speed = self.remotionFadeOffSpeed,--300,
        }
    )

    self.remotionFadeOff:reset()

end

function MatrixChar:initializeDefaultFadeOff()

    self.defaultFadeOff = FadeEffect(
        {
            alpha = self.alpha,
            initialAlpha = self.initialAlphaSetup,
            finalAlpha = self.middleAlphaSetup,
            speed = self.defaultFadeOffSpeed,--30,
        }
    )

    self.defaultFadeOff:reset()
  --  self.defaultFadeOff:start()

end

function MatrixChar:initializeChangingTimer()

    self.changingTimer = Timer(
        {
            time = self.changingTime,
            alarmFunction = function() return self:changeChar() end,
        }
    )

end

function MatrixChar:initializeDefaultFadeOffDelayTimer()

    self.defaultFadeOffDelayTimer = Timer(
        {
            time = self.defaultFadeOffDelay,
            alarmFunction = function() return self:startDefaultFadeOff() end,
        }
    )

    self.defaultFadeOffDelayTimer:setStart()


end



-- function MatrixChar:setASCIICodes()

--     self.ASCIICodes = {
--         {min = 97, max = 122}, -- ASCII lowercase letters hexadecimal code
--         {min = 30, max = 39}, -- ASCII numbers hexadecimal code
--      }

-- end

function MatrixChar:setStartColor()

    local newColor = RGBtoHSL(self.RGBColor)

    newColor.s = math.min(1, math.max(0, newColor.s - 0.8))
    newColor.l = math.min(1, math.max(0, newColor.l + 0.8))

    self.color = HSLtoRGB(newColor) 

end


function MatrixChar:update(dt)

    self:updateCharChanging(dt)
    self:updateDefaultFadeOffDelay(dt)
    self:updateDefaultFadeOff(dt)
    self:updateRemotionFadeOff(dt)
    self:checkEndOfChar()
  
end

function MatrixChar:updateCharChanging(dt)

    if self.charChanged then

        self.changingTimer:setStart()
        self.charChanged = false

    else

        self.changingTimer:update(dt)

    end

end

function MatrixChar:updateRemotionFadeOff(dt)
    
    if self.remotionFadeOff:wasStarted() then

        self.remotionFadeOff:update(dt)
        self.alpha = self.remotionFadeOff:getAlpha()

    end

end

function MatrixChar:updateDefaultFadeOffDelay(dt)

    if self.defaultFadeOffDelayTimer:hasStated() and
    self.defaultFadeOffDelayTimer:isExpired() == false then
        
        self.defaultFadeOffDelayTimer:update(dt)

    end

end

function MatrixChar:updateDefaultFadeOff(dt)
    
    if self.defaultFadeOff:wasStarted() and self.defaultFadeOff:isFinalAlpha() == false then

        self.defaultFadeOff:update(dt)
        self.alpha = self.defaultFadeOff:getAlpha()

    end

end

function MatrixChar:checkEndOfChar()

    if self.remotionFadeOff:isFinalAlpha() then
        self.endOfChar = true
    end

end

function MatrixChar:chooseRandomChar()

    local index = math.random(#self.ASCIICodes)

    self.char = string.char(
        math.random(
            self.ASCIICodes[index].min,
            self.ASCIICodes[index].max
        )
    )

end


function MatrixChar:chooseRandomColor()

    local newColor = RGBtoHSL(self.RGBColor) 

    newColor.s = math.min(1, math.max(0,newColor.s + math.pow(-1,math.random(1,2))*math.random(self.colorVariation)/100)) 
    newColor.l =  math.min(1, math.max(0,newColor.l + math.pow(-1,math.random(1,2))*math.random(self.colorVariation)/100))

    self.color = HSLtoRGB(newColor)

    --self.alpha = self.alphaSetup

end

function MatrixChar:chooseRandomAlpha()
    self.alpha = math.random(255,255)
end

function MatrixChar:changeChar()

    self:chooseRandomColor()
    self:chooseRandomChar()
   -- self:chooseRandomAlpha()
    
    self.changingTimer:reset()

    self.charChanged = true

end


function MatrixChar:render()

    love.graphics.setFont(self.font)
    love.graphics.setColor({self.color.r/255, self.color.g/255, self.color.b/255, self.alpha/255})
    
    self:print()

    love.graphics.setColor({1, 1, 1, 1})

end

function MatrixChar:print()

    if self.movableBackground then
        self.newX = self.movableBackground:getBackgroundCoordinates(self.movableBackgroundIndex).x + self.x + self.font:getHeight()/2
    else
        self.newX = self.x + self.font:getHeight()/2
    end

    self.newY = self.y + self.font:getHeight()/2

    love.graphics.print(
        self.char, 
        math.floor(self.newX),
        math.floor(self.newY),
        --math.floor(self.y + self.font:getHeight()/2),
        0,
        self.direction == 'left' and -1 or 1,
        1,
        math.floor(self.font:getHeight()/2), 
        math.floor(self.font:getHeight()/2)
    )

end

--[[
    SET FUNCTIONS
]]

function MatrixChar:startDefaultFadeOff()
    self.defaultFadeOff:start()
end

function MatrixChar:startRemotionFadeOff()
    self.remotionFadeOff:start()
end



--[[
    GET FUNCTIONS
]]
function MatrixChar:getCoordinates()

    return{
        x= self.x,
        y= self.y,
    }

end

function MatrixChar:getAlpha()
    return self.alpha
end

function MatrixChar:isEndOfChar()
    return self.endOfChar
end


function MatrixChar:hasRemotionFadeOffStarted() 
    return self.remotionFadeOff:wasStarted()
end




-- function MatrixChar:movablePrint()

--     love.graphics.print(
--         self.char, 
--         math.floor(self.movableBackground:getBackgroundCoordinates(self.movableBackgroundIndex).x + self.x + self.font:getHeight()/2),
--         math.floor(self.y + self.font:getHeight()/2),
--         0,
--         self.direction == 'left' and -1 or 1,
--         1,
--         math.floor(self.font:getHeight()/2), 
--         math.floor(self.font:getHeight()/2)
--     )

-- end

-- function MatrixChar:fixedPrint()

--     love.graphics.print(
--         self.char, 
--         math.floor(self.x + self.font:getHeight()/2),
--         math.floor(self.y + self.font:getHeight()/2),
--         0,
--         self.direction == 'left' and -1 or 1,
--         1,
--         math.floor(self.font:getHeight()/2), 
--         math.floor(self.font:getHeight()/2)
--     )

-- end

--[[
    SETTER FUNCTIONS
]]

-- function MatrixChar:setMovableBackground(mBckg, i)

--     self.movableBackground = mBckg
--     self.movableBackgroundIndex = i

-- end



