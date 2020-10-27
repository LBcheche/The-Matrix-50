--[[
    THE CODER

    Author: Leonardo G. C. Bcheche
    lbcheche@gmail.com

    Original Credits: Harvard - CS50, GD50

]]

--[[
    Given an "spritesheet" (a texture with multiple sprites), as well as a
    width and a height for the tiles therein, split the texture into
    all of the quads by simply dividing it evenly.
]]
function createTilesTable(spritesheet, tileWidth, tileHeight)
    
    local spriteSheetInTilesWidth = spritesheet:getWidth() / tileWidth
    local spriteSheetInTilesHeight = spritesheet:getHeight() / tileHeight

    local tileIndex = 1
    local tileTable = {}

    for y = 0, spriteSheetInTilesHeight - 1 do
        
        for x = 0, spriteSheetInTilesWidth - 1 do
            
            tileTable[tileIndex] =
                love.graphics.newQuad(
                    x * tileWidth, 
                    y * tileHeight, 
                    tileWidth,
                    tileHeight, 
                    spritesheet:getDimensions()
                )
            
            tileIndex = tileIndex + 1

        end
    end

    return tileTable
end


--[[
    Trigonometry functions
]]

function degreesToRadians(degree)

    return degree * math.pi / 180

end


function radiansToDegrees(radians)

    return radians * 180 / math.pi
end


--[[ 

    TABLE FUNCTIONS

]]



function removeItemFromATable(table, item)
    
    local i = getItemIndexFromATable(table,item)
    table.remove(table, i)

end

function getItemIndexFromATable(table,item)

    for index, value in pairs(table) do

        if value == item then

            return index

        end

    end

end




--[[
    Color Functions
    site: https://forum.rainmeter.net/viewtopic.php?t=23225
    by jsmorley 
]]

-- works with right notation
function RGBtoHSL(colorArg)
    
    local inRed = colorArg.r
    local inGreen = colorArg.g
    local inBlue = colorArg.b
	
	local percentR = ( inRed / 255 )
	local percentG = ( inGreen / 255 )
	local percentB = ( inBlue / 255 )

	local colorMin = math.min( percentR, percentG, percentB )
	local colorMax = math.max( percentR, percentG, percentB )
	local deltaMax = colorMax - colorMin

	local colorBrightness = colorMax

    if (deltaMax == 0) then
        
        local colorHue = 0
        local colorSaturation = 0
        
        return {h = colorHue, s = colorSaturation, l = colorBrightness}

	else
        
        local colorSaturation = deltaMax / colorMax

		local deltaR = (((colorMax - percentR) / 6) + (deltaMax / 2)) / deltaMax
		local deltaG = (((colorMax - percentG) / 6) + (deltaMax / 2)) / deltaMax
		local deltaB = (((colorMax - percentB) / 6) + (deltaMax / 2)) / deltaMax

        local colorHue = 0

		if (percentR == colorMax) then
            
            colorHue = deltaB - deltaG
            
		elseif (percentG == colorMax) then 
            
            colorHue = ( 1 / 3 ) + deltaR - deltaB
            
		elseif (percentB == colorMax) then 
            
            colorHue = ( 2 / 3 ) + deltaG - deltaR
            
		end

		if ( colorHue < 0 ) then colorHue = colorHue + 1 end
		if ( colorHue > 1 ) then colorHue = colorHue - 1 end
        
        return {h = colorHue, s = colorSaturation, l = colorBrightness}

	end

end


function HSLtoRGB(params)
    
    local colorHue = params.h 
    local colorSaturation = params.s
    local colorBrightness = params.l
    local percentR = 0
    local percentG = 0
    local percentB = 0

    local degreesHue = colorHue * 6
    
    if (degreesHue == 6) then degreesHue = 0 end
    degreesHue_int = math.floor(degreesHue)
    
    local percentSaturation1 = colorBrightness * (1 - colorSaturation)
    local percentSaturation2 = colorBrightness * (1 - colorSaturation * (degreesHue - degreesHue_int))
    local percentSaturation3 = colorBrightness * (1 - colorSaturation * (1 - (degreesHue - degreesHue_int)))
    
    if (degreesHue_int == 0)  then
        percentR = colorBrightness
        percentG = percentSaturation3
        percentB = percentSaturation1
    elseif (degreesHue_int == 1) then
        percentR = percentSaturation2
        percentG = colorBrightness
        percentB = percentSaturation1
    elseif (degreesHue_int == 2) then
        percentR = percentSaturation1
        percentG = colorBrightness
        percentB = percentSaturation3
    elseif (degreesHue_int == 3) then
        percentR = percentSaturation1
        percentG = percentSaturation2
        percentB = colorBrightness
    elseif (degreesHue_int == 4) then
        percentR = percentSaturation3
        percentG = percentSaturation1
        percentB = colorBrightness
    else
        percentR = colorBrightness
        percentG = percentSaturation1
        percentB = percentSaturation2
    end

    local outRed = math.min(255, math.max(0, math.floor(percentR * 255)))
    local outGreen = math.min(255, math.max(0, math.floor(percentG * 255)))
    local outBlue = math.min(255, math.max(0, math.floor(percentB * 255)))
    
    return {r = outRed, g = outGreen, b = outBlue}
	
end




function isEven(number)
    
    if number % 2 == 0 then
        return true
    end
    
    return false 
end




