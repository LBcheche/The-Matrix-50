--[[
    THE MATRIX 50

    Copyright (c) 2020
    Author: Leonardo Geo C. Bcheche
    lbcheche@gmail.com

    Matrix Code Line

]]

MatrixCodeLine = Class{}

--[[ 
    INITIAL FUNCTIONS
]]

function MatrixCodeLine:init(params)

    
    -- self.startX = params.startX
    -- self.startY = params.startY

    -- CHAR PARAMETERS
    self.font = params.font -- char's codeline font
    self.colorVariation = params.colorVariation -- color range for saturation and lightness
    self.changingTime = params.changingTime -- frequency to change the codeline
    self.rgbColor = params.rgbColor -- table that represents a color of char's font:  {r = , g= , b= }
    self.direction = params.direction -- char's writing direction 
    self.ASCIICodes = params.ASCIICodes -- list of tables that represents possible chars for a Matrix Char
    -- Example for ASCIICode table {{min = , max = },{min = , max = },{min = , max = },  }
    self.initialAlphaSetup = params.initialAlphaSetup--255
    self.middleAlphaSetup = params.middleAlphaSetup--150
    self.finalAlphaSetup = params.finalAlphaSetup-- 0
    self.remotionFadeOffSpeed = params.remotionFadeOffSpeed
    self.defaultFadeOffSpeed = params.defaultFadeOffSpeed
    self.defaultFadeOffDelay = params.defaultFadeOffDelay

    self.movableBackground = params.movableBackground or nil
    self.movableBackgroundIndex = params.movableBackgroundIndex or nil

    -- LINE CODE PARAMETERS
    self.widthInChar = params.widthInChar -- area width  where a codeline can be placed measured in chars
    self.heightInChar = params.heightInChar -- area height where a codeline can be placed measured in chars
    self.minTimeMilisec = params.minTimeMilisec -- minimum time for code line's wating time state
    self.maxTimeMilisec = params.maxTimeMilisec -- maximum time for code line's wating time state
    self.minCodeLineHeightInChar = params.minCodeLineHeightInChar -- min height in char a code line may have
    self.maxCodeLineHeightInChar = params.maxCodeLineHeightInChar -- max height in char a code line may have
 
    -- MATRIX FX PARAMETERS 
    self.matrixFX = params.matrixFX


    -- Setup Functions 
    self:initializeLineHeightInChar()
    self:initializeWaitingTime()
    self:initializeCoordinates()
    self:initializeTimers()
    self:initializeUpdateStateMachine()

    self.codeLineState = 'addition'

    self.codeLine = {}

    self:addNewChar()

    self.endOfCodeLine = false
    

    
end



--Function responsable for choose an random code line height
function MatrixCodeLine:initializeLineHeightInChar()

    self.codeLineHeightInChar = math.random(self.minCodeLineHeightInChar, self.maxCodeLineHeightInChar)
    
end



-- Function responsable for setup a random time for 'waiting' code line state
function MatrixCodeLine:initializeWaitingTime()

    self.waitingTime = math.random(self.minTimeMilisec, self.maxTimeMilisec)/1000

end



-- Function responsable for setup a random coordinates for a this code line
function MatrixCodeLine:initializeCoordinates()

    self.x = math.random(0, self.widthInChar - 1) * (gVirtualFontWidth)
    self.y = math.random(0,math.floor(self.heightInChar - self.codeLineHeightInChar)) * (gVirtualFontHeight)

end



-- Function responsable for setup each code line state's timer
function MatrixCodeLine:initializeTimers()

    self.addCharTimer = Timer(
        {
            time = self.changingTime/5,
            alarmFunction = function() return self:addNewChar() end,
        }
    )

    self.waitingTimer = Timer( 
        {
            time = self.waitingTime,
            alarmFunction = function() return self:startRemovingChar() end,
        }
    )

    self.charRemotionTimer = Timer(
        {
            time = self.changingTime/3,
            alarmFunction = function() return self:removeOlderChar() end,
        }
    )

end



-- Function responsable for setup a table that represents an code line's update state machine
function MatrixCodeLine:initializeUpdateStateMachine()

    self.timerUpdateStates = {
        ['addition'] = function(dt) return self:charAditionUpdate(dt) end,
        ['waiting'] =  function(dt) return self:waitingTimerUpdate(dt) end,
        ['remotion'] = function(dt) return self:remotionUpdate(dt) end,
    }

end


--[[ 
    ALARM FUNCTIONS
]]

-- Function responsable for add a new char at code line after its timer.
function MatrixCodeLine:addNewChar()
    
    if #self.codeLine < self.codeLineHeightInChar then 
        
        local newChar = self:createAChar()

        self:checkOverwriting(newChar) 

        self:setNextCoordinates()

        table.insert(self.codeLine, newChar)

        self.charAdded = true

    else 

        self.waitingTimer:setStart()
        self.codeLineState = 'waiting'

    end
    
    self.addCharTimer:reset()
    
end



-- Function responsable for check a char overwriting 
-- at Matrix Script before adding a new char at current code line
-- and remove the older char from another code line if it so. 
function MatrixCodeLine:checkOverwriting(newChar)

    for k, codeLine in pairs(self.matrixFX:getMatrix()) do 

        if codeline ~= self then
            
            for i, char in pairs(codeLine:getCodeLine()) do
                
                if newChar:getCoordinates().x == char:getCoordinates().x and 
                newChar:getCoordinates().y == char:getCoordinates().y then
                    
                   table.remove(codeLine:getCodeLine(),i)

                end  

            end

        end
    end
    
end

function MatrixCodeLine:chooseColor()

    self.allColors = {"vscode1","vscode1", "vscode1","vscode2","vscode3","vscode4","vscode5","vscode6","vscode7","vscode8","vscode8","vscode8","vscode9", "vscode10","vscode10","vscode10", "vscode11", "vscode12"}--{"pink", "purple", "blue","green", "yellow"}
    self.rgbColor = gRGBColors[self.allColors[math.random(#self.allColors)]]

end

-- Function responsable for create a new Matrix Char object
function MatrixCodeLine:createAChar()

--   self:chooseColor()

    return MatrixChar(
        {
            font = self.font,
            x = self.x,
            y = self.y,
            changingTime = self.changingTime,
            rgbColor = self.rgbColor,
            colorVariation = self.colorVariation,
            direction = 'left',
            ASCIICodes =self.ASCIICodes,
            movableBackground = self.movableBackground,
            movableBackgroundIndex = self.movableBackgroundIndex,
            codeLine = self,
            initialAlphaSetup = self.initialAlphaSetup,
            middleAlphaSetup = self.middleAlphaSetup,
            finalAlphaSetup = self.finalAlphaSetup,
            remotionFadeOffSpeed = self.remotionFadeOffSpeed,
            defaultFadeOffSpeed = self.defaultFadeOffSpeed,
            defaultFadeOffDelay = self.defaultFadeOffDelay,
          
        }
    )

end



-- Function responsable for setup next char coordinates.
-- Once matrix effect is vertical, just changes y position. 
function MatrixCodeLine:setNextCoordinates()

    self.y = self.y + gVirtualFontHeight

end



-- Function responsable for initiate char remotion 
-- after waiting state.
function MatrixCodeLine:startRemovingChar()
    
    self.waitingTimer:reset()
    self.codeLineState = 'remotion'

    self:removeOlderChar()
    

end


-- Function responsable for remove first code line's 
-- char until it's empty
function MatrixCodeLine:removeOlderChar()

    if #self.codeLine > 0 and 
    self.codeLine ~= nil then
        local startedFadeOff = false

        --table.remove(self.codeLine,1)
        self:startNextCharFadeOff()
        self.charRemoved = true
        
    else
        self.endOfCodeLine = true
    end

    self.charRemotionTimer:reset()

end



-- Function responsable for start next char's fade off at
-- remotion fade off cicle.
function MatrixCodeLine:startNextCharFadeOff()

    local startedFadeOff = false

    for index, char in pairs(self.codeLine) do

        if char:hasRemotionFadeOffStarted() == false and 
        startedFadeOff == false then
            
            char:startRemotionFadeOff()
            startedFadeOff = true

        end

    end

end



-- Function responsable for check "End Of Char" flaged 
-- chars and remove it from code line if it so. 
function MatrixCodeLine:checkEndOfChar()

    for index, char in pairs(self.codeLine) do

        if char:isEndOfChar() == true then

            table.remove(self.codeLine,index)

        end

    end

end



--[[
    UPDATE FUNCTIONS
]]

-- Function responsable for update each code line's
-- state and make animation possible
function MatrixCodeLine:update(dt)

    self.timerUpdateStates[self.codeLineState](dt)
    self:charUpdate(dt)

end



-- Function responsable for update each Matrix Char
-- on this code line.
function MatrixCodeLine:charUpdate(dt)
    
    for k, char in pairs(self.codeLine) do
        char:update(dt)
    end

end



-- Function responsable for update add char timer
-- on addition state
function MatrixCodeLine:charAditionUpdate(dt)

    if self.charAdded == false then
        self.addCharTimer:update(dt)
    else
        self.addCharTimer:setStart()
        self.charAdded = false
    end

end



-- Function responsable for update waiting timer
-- on waiting state
function MatrixCodeLine:waitingTimerUpdate(dt)

    self.waitingTimer:update(dt)

end



-- Function responsable for update char remotion
-- timer on remotion state
function MatrixCodeLine:remotionUpdate(dt)

    if self.charRemoved == false then

        self.charRemotionTimer:update(dt)

    else

        self.charRemotionTimer:setStart()
        self.charRemoved = false

    end

    self:checkEndOfChar()

end



--[[
    RENDER FUNCTIONS
]]


-- Function responsable for render each char on code line.
function MatrixCodeLine:render()

    for k, char in pairs(self.codeLine) do

        char:render()

    end

end



--[[
    IS/ GET FUNCTIONS
]]



-- Function responsable for return code line's
-- list of chars.
function MatrixCodeLine:getCodeLine()
    return self.codeLine
end


-- Function responsable for inform MatrixFX 
-- this object can be erased
function MatrixCodeLine:isEndOfCodeLine()

    return self.endOfCodeLine

end