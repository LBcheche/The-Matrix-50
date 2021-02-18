--[[
    THE MATRIX 50

    Copyright (c) 2020
    Author: Leonardo Geo C. Bcheche
    lbcheche@gmail.com

    DEPENDENCIES
]]

Class = require 'lib/class'

-- PUSH CLASS
-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
-- https://github.com/Ulydev/push
push = require 'lib/push'

require 'lib/FadeEffect'
require 'src/Util'
require 'src/Timer'

require 'src/MatrixFX/MatrixChar'
require 'src/MatrixFX/MatrixCodeLine'
require 'src/MatrixFX/MatrixFX'
require 'src/MatrixFX/MatrixParalax'


require 'src/ScreenStateMachine/States/TheMatrix'
require 'src/ScreenStateMachine/BaseState'
require 'src/ScreenStateMachine/StateMachine'



