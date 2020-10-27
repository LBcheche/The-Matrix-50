--[[
    THE MATRIX 50

    Copyright (c) 2020
    Author: Leonardo Geo C. Bcheche
    lbcheche@gmail.com

    Matrix FX Paralax

]]

MatrixParalax = Class{}

--[[
    backgroundList{ 
        {matrix = , loopingWidth =  },
        {matrix = , loopingWidth =  },
        {matrix = , loopingWidth =  },
    }
]]

function MatrixParalax:init(params)

    self.matrixBackgrouds = params.matrixBackgrouds
    self.baseSpeed = params.baseSpeed
    self.type = params.type or 'paralax' -- or 'vertical' for vertical motion

    self.backgroundList = {}

    self.backgroundStartParams = {
        ['paralax'] = function() return self:defineParalaxParams() end,
        -- ['vertical'] = function() return self:defineVerticalParams() end,
    }

    self.backgroundUpdate = {
        ['paralax'] = function(dt,camX) return self:updateParalax(camX) end,
        -- ['vertical'] = function(dt,camX) return self:updateVertical(dt) end,
    }

    self:clearBackgroundList()
    self:defineBackgroundStartParams()

end

function MatrixParalax:clearBackgroundList()

    for i = 1, #self.matrixBackgrouds do
        self.backgroundList[i] = {
            matrix = nil,
            loopingWidth = nil,
            speed = nil,
            x = nil,
            y = nil,
        }
    end

end

function MatrixParalax:defineBackgroundStartParams()

    self.backgroundStartParams[self.type]()

end

function MatrixParalax:defineParalaxParams()
    
    for i = 1,  #self.matrixBackgrouds do
        self.backgroundList[i].matrix = self.backgroundList[i].matrix -- gBackGroundImages[self.levelTheme][i]
        self.backgroundList[i].loopingWidth = self.backgroundList[i].loopingWidth
        self.backgroundList[i].speed = (self.baseSpeed + (i - 1) * 0.15)
        self.backgroundList[i].x = 0
        self.backgroundList[i].y = VIRTUAL_HEIGHT - self.backgroundList[i].matrix:getHeight() -- gBackGroundImages[self.levelTheme][i]:getHeight()
    end

end

function MatrixParalax:update(dt,camX)

    self.backgroundUpdate[self.type](dt,camX)

end

function MatrixParalax:updateParalax(camX)

    for i = 1, #self.backgroundList do
        self.backgroundList[i].x = (camX * self.backgroundList[i].speed) %  self.backgroundList[i].loopingWidth
    end

end

function MatrixParalax:render()

    -- love.graphics.clear(1,1,1,1)
 
    for i =  #self.backgroundImages, 1, -1  do

        love.graphics.draw(
            self.backgroundList[i].image, 
            math.floor(self.backgroundList[i].x), 
            math.floor(self.backgroundList[i].y)
        )

    end

    --love.graphics.clear(1,1,1,1)
 
end

function MatrixParalax:getBackgroundCoordinates(index)

    return {
        x = self.backgroundList[i].x,
        y = self.backgroundList[i].y,
    }

end



