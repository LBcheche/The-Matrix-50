--[[

Timer Class

Copyright (c) 2020 Leonardo Bcheche

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Except as contained in this notice, the name(s) of the above copyright holders
shall not be used in advertising or otherwise to promote the sale, use or
other dealings in this Software without prior written authorization.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

]]--

Timer = Class{}

function Timer:init(params)

    self.timeSetup = params.time
    self.time = params.time
    self.alarmFunction = params.alarmFunction -- this fielf must be a client callback function
    self.expired = false
    self.start = false
    self.continuous = params.continuous or false

    self.startFunction = params.startFunction or nil -- this fielf must be a client callback function
    self.startFunctionRunned = false

end


function Timer:update(dt)

    if self.start == true and 
    self.expired == false then

        self:checkExpiredAndAlarm()
        self:decreaseTime(dt)

        if self.startFunctionRunned == false and self.startFunction then

            self.startFunction()
            self.startFunctionRunned = true

        end

    end
end


function Timer:checkExpiredAndAlarm()

    if self.time <= 0 then

        self.alarmFunction()
        self.expired = true

        if self.continuous then

            self:reset()
            self:setStart()
            
        end
    end

end


function Timer:decreaseTime(dt)

    self.time = math.max(0, self.time - dt)

end


function Timer:reset()

    self.start = false
    self.expired = false
    self.time = self.timeSetup
    self.startFunctionRunned = false

end

function Timer:setAlarmFunction(afunction)

    self.alarmFunction = afunction

end


function Timer:setStart()

    self.start = true
    self.expired = false
    
end

function Timer:setTime(time)

    self.time = time
    self.timeSetup = time

end


function Timer:setPause()
    
    self.start = false

end

function Timer:getTime()

    return self.time

end

function Timer:isExpired()

    return self.expired

end

function Timer:hasStated()

    return self.start

end

function Timer:getTimeSetup()
    return self.timeSetup
end

