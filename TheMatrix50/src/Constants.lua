--[[
    THE MATRIX 50

    Author: Leonardo Geo C. Bcheche
    lbcheche@gmail.com

    Copyright (c) 2020

    Credit for Font:
    http://www.dafont.com
]]

-- GLOBAL CONTANTS

require 'src/Dependencies'
--[[
    SCREEN CONSTANTS
]]

-- real physical screen dimensions in pixels
WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080

-- virtual resolution dimensions in pixels
-- VIRTUAL_WIDTH = 640
-- VIRTUAL_HEIGHT = 360

VIRTUAL_WIDTH = 1920
VIRTUAL_HEIGHT = 1080

-- screen tile width and height in pixels
SCREEN_TILE_SIZE = 16

-- screen dimensions in tiles
SCREEN_WIDTH_IN_TILES = VIRTUAL_WIDTH/SCREEN_TILE_SIZE
SCREEN_HEIGHT_IN_TILES = VIRTUAL_HEIGHT/SCREEN_TILE_SIZE



--[[
    LEVEL CONSTANTS
]]


gColors = {
    ['background'] = {30/255, 30/255, 30/255, 255/255},
    ['title'] = {73/255, 156/255, 214/255, 255/255},
    ['name'] = {206/255, 145/255, 120/255, 255/255},
    ['highlighted'] = {220/255, 220/255, 170/255, 255/255}, -- ligth yellow
    ['enabled'] = {197/255, 134/255, 192/255, 255/255},  -- ligth pink
    ['desabled'] =  {77/255, 75/255, 78/255, 255/255},
    ['numbers'] = {167/255, 206/255, 168/255, 255/255},
    ['terminalLight'] = {212/255, 212/255, 212/255, 255/255},
    ['terminalMedium'] = {133/255, 133/255, 133/255, 255/255},
    ['terminalDark'] = {100/255, 100/255, 100/255, 255/255},
    ['red'] = {218/255, 49/255, 49/255, 255/255},
    ['green'] = {106/255, 153/255, 105/255, 255/255},
}

gRGBColors = {
   -- ['green'] = {name = 'green', r = 107, g = 193, b = 190},
   -- ['green'] = {name = 'green', r = 82, g = 234, b = 103},
    ['green'] = {name = 'green', r = 0, g = 246, b =0},
    ['pink'] = {name = 'pink',r = 235, g = 18, b =123},
    ['white'] = {name = 'white',r = 255, g = 255, b =255},
    ['red'] = {name = 'red',r = 156 , g = 30, b = 64},
    ['black'] = {name = 'black',r = 0 , g = 0, b = 0},
    ['purple'] = {name = 'purple',r = 130 , g = 87, b = 230},
    ['blue'] = {name = 'blue',r = 38 , g = 139, b = 187},
    ['total green'] = {name = 'total green',r = 0 , g = 255, b = 0},
    ['total red'] = {name = 'total red',r = 255 , g = 0, b = 0},
    ['yellow'] = {name = 'yellow', r= 255, g=255, b=121},
    ['orange'] = {name = 'orange', r= 236, g=107, b=0},

    ['vscode1'] = {name = 'vscode1', r= 86, g=156, b=214},
    ['vscode2'] = {name = 'vscode2', r= 206, g=145, b=120},
    ['vscode3'] = {name = 'vscode3', r= 181, g=206, b=168},
    ['vscode4'] = {name = 'vscode4', r= 106, g=153, b=85},
    ['vscode5'] = {name = 'vscode5', r= 215, g=186, b=125},
    ['vscode6'] = {name = 'vscode6', r= 244, g=71, b=71},
    ['vscode7'] = {name = 'vscode7', r= 128, g=128, b=128},
    ['vscode8'] = {name = 'vscode8', r=156 , g=220, b=254},
    ['vscode9'] = {name = 'vscode9', r= 209, g=105, b=105},
    ['vscode10'] = {name = 'vscode10', r=197 , g=134, b=192},
    ['vscode11'] = {name = 'vscode11', r=220 , g=220, b=170},
    ['vscode12'] = {name = 'vscode12', r= 78, g=201, b=176}

}

gASCIICodes = {
    ['alphanumeric'] = {
        name ='alphanumeric', 
        codes = {
            {min = 97, max = 122}, -- ASCII lowercase letters hexadecimal code
            {min = 48, max = 57}, -- ASCII numbers hexadecimal code
            
        }
    },
    ['binary'] = { 
        name ='binary', 
        codes = {
            {min = 48, max = 49},
        }
    },
    ['lowercase_ponctuation'] = {
        name ='lowercase_ponctuation', 
        codes = {
            {min = 97, max = 122}, -- ASCII lowercase letters hexadecimal code
            {min = 48, max = 57}, -- ASCII numbers hexadecimal code
            {min = 58, max = 62}
        }
    },
}


gFonts = {
    ['SUPERPHU'] = {name = 'SUPERPHU', font = love.graphics.newFont('fonts/SUPERPHU.ttf', 10)},
    ['5psycho'] = {name = '5psycho', font = love.graphics.newFont('fonts/5psycho.ttf', 16)},
    ['tiny'] = {name = 'tiny', font = love.graphics.newFont('fonts/tiny.ttf', 6)},
    --['TINYBBA_'] = {name = 'TINYBBA_', font = love.graphics.newFont('fonts/TINYBBA_.ttf', 10)},
    ['pixel'] = {name = 'pixel', font = love.graphics.newFont('fonts/pixel.ttf', 16)},
    ['spacy'] = {name = 'spacy', font = love.graphics.newFont('fonts/SpacyStuff.ttf', 16)},
    ['bmrea'] = {name = 'bmrea', font = love.graphics.newFont('fonts/bmrea.ttf', 16)},
    ['invaders'] = {name = 'invaders', font = love.graphics.newFont('fonts/pixel_invaders.ttf', 16)},
    ['japanese'] = {name = 'japanese', font = love.graphics.newFont('fonts/japanese.ttf', 24)},
    ['small'] = {name = 'small', font = love.graphics.newFont('fonts/font.ttf', 8)},
    ['medium'] = {name = 'medium', font = love.graphics.newFont('fonts/font.ttf', 16)},
    ['medium_large'] = {name = 'medium_large', font = love.graphics.newFont('fonts/font.ttf', 24)},
    ['large'] = {name = 'large', font = love.graphics.newFont('fonts/font.ttf', 32)},
    ['big'] = {name = 'big', font = love.graphics.newFont('fonts/font.ttf', 48)},
    ['matrix'] = {name = 'big', font = love.graphics.newFont('fonts/matrix.ttf', 32)},
    ['elven'] = {name = 'big', font = love.graphics.newFont('fonts/elven.ttf', 24)},
    ['elven2'] = {name = 'big', font = love.graphics.newFont('fonts/halfelvenbold.ttf', 24)},
    ['kindergarten'] = {name = 'big', font = love.graphics.newFont('fonts/kindergarten.ttf', 32)},
    ['norskode'] = {name = 'big', font = love.graphics.newFont('fonts/norskode.ttf', 16)},
    ['katakana'] = {name = 'big', font = love.graphics.newFont('fonts/katakana.ttf', 42)},
    ['hiragana'] = {name = 'big', font = love.graphics.newFont('fonts/bd_hiragana_kuro.otf', 42)},
    ['flow'] = {name = 'flow', font = love.graphics.newFont('fonts/flow.ttf', 28)},
    ['original'] = {name = 'original', font = love.graphics.newFont('fonts/mCode15.ttf', 36)},
    ['consolas'] = {name = 'big', font = love.graphics.newFont('fonts/consolas.ttf', 32)}
}

aFont = gFonts['consolas']
aASCII = gASCIICodes['alphanumeric']


FONT_DELTA_WIDHT = 0
FONT_DELTA_HEIGHT = 0

gVirtualFontWidth = aFont.font:getHeight() + FONT_DELTA_WIDHT
gVirtualFontHeight = aFont.font:getHeight() + FONT_DELTA_HEIGHT

gMatrixParams = {

    ['original'] = {

        --[[ 
            INFORMATION PARAMETERS
        ]]

        fontName = aFont.name, -- information to show on screen
        ASCIIType = aASCII.name, -- information to show on screen
        
        --[[ 
            CHAR PARAMETERS
        ]]
        
        font = aFont.font,  -- char's codeline font
        colorVariation = 10, -- color range for saturation and lightness in %
        changingTime = 0.15, -- frequency to change the codeline in seconds
        rgbColor = gRGBColors['green'], -- table that represents a color of char's font:  {r = , g= , b= }
        direction = 'left', -- char's writing direction 
        ASCIICodes = aASCII.codes, -- list of tables that represents possible chars for a Matrix Char: Example for ASCIICode table {{min = , max = },{min = , max = },{min = , max = },  }
        initialAlphaSetup = 255, -- char's initial alpha setup before defaut fade off (first fade off)
        middleAlphaSetup = 150, -- char's final alpha setup after default fade off / char's initial alpha setup before remotion fade off
        finalAlphaSetup = 0, -- char's final alpha setup after remotion fade off
        defaultFadeOffDelay = 0.7, -- default fade off delay in seconds
        defaultFadeOffSpeed = 60, -- default fade off speed in dt
        remotionFadeOffSpeed = 300, -- remotion fade off speed in dt

        --[[ 
            CODE LINE PARAMETERS
        ]]

        widthInChar = math.floor((VIRTUAL_WIDTH)/ (gVirtualFontWidth)), -- area width where a codeline can be placed measured in chars
        heightInChar = math.floor((VIRTUAL_HEIGHT)/ (gVirtualFontHeight)), -- area height where a codeline can be placed measured in chars
        minTimeMilisec = 1000, -- minimum time for code line's wating time state in milisecond
        maxTimeMilisec = 2000, -- maximum time for code line's wating time state in milisecond
        minCodeLineHeightInChar = 10, --10 min height in char a code line may have
        maxCodeLineHeightInChar = 30, --30 max height in char a code line may have

        --[[ 
            MATRIX FX (SCRIPT) PARAMETERS
        ]]

        minCodeLinesNumberPerAddition = 5, -- 8 minimum code lines can be add in an adition cicle.
        maxCodeLinesNumberPerAddition = 10, -- 10 maximum code lines can be add in an adition cicle.
        minAdditionNumberBeforeWaiting = 20, -- 20 minimum adition cicles must happen before waiting cicle.
        maxAdditionNumberBeforeWaiting = 30, -- 30 maximum adition cicles must happen before waiting cicle.
        infinitable = true, -- setup if after an addition and waiting cicle, Matrix FX will restart the cicle again.
    },

}



