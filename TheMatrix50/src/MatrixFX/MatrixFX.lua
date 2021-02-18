
--[[
    THE MATRIX 50

    Copyright (c) 2020
    Author: Leonardo Geo C. Bcheche
    lbcheche@gmail.com

    Matrix FX Class

]]

MatrixFX = Class{}

--[[
    INITIAL FUNCTIONS
]]
function MatrixFX:init(params)

    -- Char's Parameters
    self.font = params.matrixParams.font -- char's codeline font
    self.changingTime = params.matrixParams.changingTime -- frequency to change the codeline
    self.rgbColor = params.matrixParams.rgbColor -- table that represents a color of char's font:  {r = , g= , b= }
    self.direction = params.matrixParams.direction -- char's writing direction 
    self.ASCIICodes = params.matrixParams.ASCIICodes -- list of tables that represents possible chars for a Matrix Char
    self.colorVariation = params.matrixParams.colorVariation -- color range for saturation and lightness
    self.initialAlphaSetup = params.matrixParams.initialAlphaSetup
    self.middleAlphaSetup = params.matrixParams.middleAlphaSetup
    self.finalAlphaSetup = params.matrixParams.finalAlphaSetup 
    self.remotionFadeOffSpeed = params.matrixParams.remotionFadeOffSpeed
    self.defaultFadeOffSpeed = params.matrixParams.defaultFadeOffSpeed
    self.defaultFadeOffDelay = params.matrixParams.defaultFadeOffDelay

    -- Code Line's Parameters
    self.widthInChar = params.matrixParams.widthInChar -- area width  where a codeline can be placed measured in chars
    self.heightInChar = params.matrixParams.heightInChar -- area height where a codeline can be placed measured in chars
    self.minTimeMilisec = params.matrixParams.minTimeMilisec -- minimum time for code line's wating time state
    self.maxTimeMilisec = params.matrixParams.maxTimeMilisec -- maximum time for code line's wating time state
    self.minCodeLineHeightInChar = params.matrixParams.minCodeLineHeightInChar -- min height in char a code line may have
    self.maxCodeLineHeightInChar = params.matrixParams.maxCodeLineHeightInChar -- max height in char a code line may have

    -- Matrix Parameters
    self.minCodeLinesNumberPerAddition = params.matrixParams.minCodeLinesNumberPerAddition
    self.maxCodeLinesNumberPerAddition = params.matrixParams.maxCodeLinesNumberPerAddition
    self.minAdditionNumberBeforeWaiting = params.matrixParams.minAdditionNumberBeforeWaiting
    self.maxAdditionNumberBeforeWaiting = params.matrixParams.maxAdditionNumberBeforeWaiting
    self.infinitable = params.matrixParams.infinitable

   -- self.movableBackground = params.movableBackground or nil
    --self.movableBackgroundIndex = params.movableBackground or nil

    self.matrix = {}

    self:initializeUpdateStateMachine()
    self:initializeTimers()
    self:chooseAdditionNumberBeforeWaiting()
    self.additionsCounting = 0

    
    self.codeLineAdditionTimer:setStart()
    
    
end


-- Function responsable for initialize Update State Machine
-- and current state.
function MatrixFX:initializeUpdateStateMachine()

    self.matrixTimerUpdateStates = {
        ['addition'] = function(dt) return self:additionUpdate(dt) end,
        ['waiting'] =  function(dt) return self:waitingUpdate(dt) end,
    }

    self.matrixState = 'addition'

end


-- Function responsable for initialize all Timers
function MatrixFX:initializeTimers()

    self.creationPeriod = self.changingTime*3

    self.codeLineAdditionTimer = Timer(
        {
            time = self.creationPeriod,
            alarmFunction = function() return self:createCodeLines() end,
        }
    )

    self.codeLineAdded = false

    self.waitingTimer = Timer(
        {
            time = self.creationPeriod * 2/3,
            alarmFunction = function() return self:returnCreation() end,
        }
    )

    self.timeWaited = false

end


-- Function responsable for randomly choose a number of
-- code line addition cicles before waiting cicle. 
function MatrixFX:chooseAdditionNumberBeforeWaiting()

    self.additionNumberBeforeWaiting = math.random(
        self.minAdditionNumberBeforeWaiting,
        self.maxAdditionNumberBeforeWaiting
    )

end



--[[
    ALARM FUNCTIONS
]]


-- Function responsable for create code lines 
-- on Matrix "Script" and runned at each addition cicle.
function MatrixFX:createCodeLines()

    self:chooseCodeLinesNumberPerAddition()
    self:addCodeLinesOnMatrix()

end


-- Function responsable for randomly choose a number of
-- code lines per addition cicle.  
function MatrixFX:chooseCodeLinesNumberPerAddition()

    self.codeLinesNumberPerAddition = math.random(
        self.minCodeLinesNumberPerAddition,
        self.maxCodeLinesNumberPerAddition
    )

end


-- Function responsable for add code lines 
-- on Matrix Script.
function MatrixFX:addCodeLinesOnMatrix()

    if self.additionsCounting <= self.additionNumberBeforeWaiting then
        
        for i = 1, self.codeLinesNumberPerAddition do

            local newCodeLine = self:createCodeLine()
            table.insert(self.matrix, newCodeLine)

        end

        self.additionsCounting = self.additionsCounting + 1
        self.codeLineAdded = true

    else

        self.waitingTimer:setStart()
        self.timeWaited = false
        self.matrixState = 'waiting'

    end

    self.codeLineAdditionTimer:reset()

end

function MatrixFX:chooseColor()

    self.allColors = {"pink", "purple", "blue","green", "yellow"}
    self.rgbColor = gRGBColors[self.allColors[math.random(5)]]

end


-- Function responsable for instatiate a new 
-- code line object. 
function MatrixFX:createCodeLine()

    --self:chooseColor()

    return MatrixCodeLine(
        {
            font = self.font, 
            colorVariation = self.colorVariation,
            changingTime = self.changingTime,
            rgbColor = self.rgbColor,
            direction = self.direction,
            ASCIICodes = self.ASCIICodes,
   
            initialAlphaSetup = self.initialAlphaSetup,
            middleAlphaSetup = self.middleAlphaSetup,
            finalAlphaSetup = self.finalAlphaSetup,
            remotionFadeOffSpeed = self.remotionFadeOffSpeed,
            defaultFadeOffSpeed = self.defaultFadeOffSpeed,
            defaultFadeOffDelay = self.defaultFadeOffDelay,

            initialAlphaSetup = self.initialAlphaSetup,
            middleAlphaSetup = self.middleAlphaSetup,
            finalAlphaSetup = self.finalAlphaSetup,
            remotionFadeOffSpeed = self.remotionFadeOffSpeed,
            defaultFadeOffSpeed = self.defaultFadeOffSpeed,
            movableBackground = self.movableBackground,
            movableBackgroundIndex = self.movableBackgroundIndex,

            widthInChar = self.widthInChar, 
            heightInChar = self.heightInChar,
            minTimeMilisec = self.minTimeMilisec,
            maxTimeMilisec = self.maxTimeMilisec,
            minCodeLineHeightInChar = self.minCodeLineHeightInChar,
            maxCodeLineHeightInChar = self.maxCodeLineHeightInChar,
            matrixFX = self,

        }
    )

end


-- Function responsable for restart code line 
-- addition.
function MatrixFX:returnCreation()

    self.waitingTimer:reset()
    
    if self.infinitable then
        
        self.additionsCounting = 0
        self:chooseAdditionNumberBeforeWaiting()
        self.matrixState = 'addition'
        self.codeLineAdded = false
        self.codeLineAdditionTimer:setStart()

    end

end


--[[
    UPDATE FUNCTIONS
]]
function MatrixFX:update(dt)

    self.matrixTimerUpdateStates[self.matrixState](dt)
    self:eraseOldCodeLines()
    self:matrixUpdate(dt)

end


-- Function responsable for erase code lines
-- flaged as "End Of Code Line"
function MatrixFX:eraseOldCodeLines()

    for k, codeLine in pairs(self.matrix) do

        if codeLine:isEndOfCodeLine() then

            table.remove(self.matrix, k)

        end

    end

end



-- Function responsable for update 
-- addtion cicle.
function MatrixFX:additionUpdate(dt) 

    if self.codeLineAdded == false then
        self.codeLineAdditionTimer:update(dt)
    else
        self.codeLineAdditionTimer:setStart()
        self.codeLineAdded = false
    end


end



-- Function responsable for update
-- waiting cicle.
function MatrixFX:waitingUpdate(dt) 

    if self.timeWaited == false then
        self.waitingTimer:update(dt)
    else
        self.waitingTimer:setStart()
        self.timeWaited = false
    end

end



-- Function responsable for update each
-- code line at Matrix Script.
function MatrixFX:matrixUpdate(dt)

    for k, codeLine in pairs(self.matrix) do

        codeLine:update(dt)

    end

end



--[[
    RENDER FUNCTIONS
]]
function MatrixFX:render()

    for k, codeLine in pairs(self.matrix) do

        codeLine:render()

    end

end


--[[ 
    GETTER FUNCTIONS
]]


-- Function responsable for return Matrix Height
function MatrixFX:getHeight()

    return self.heightInChar * self.font:getHeight()

end


-- Function responsable for set a Movable Background at Matrix FX
-- object
function MatrixFX:setMovableBackground(mBckg, i)

    self.movableBackground = mBckg
    self.movableBackgroundIndex = i

end


-- Function responsable for return the Matrix Script itself.
function MatrixFX:getMatrix()
    return self.matrix
end