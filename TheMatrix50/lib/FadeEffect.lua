--[[

Fade Effect Class

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

FadeEffect = Class{}


function FadeEffect:init(params)

    self.alpha = params.alpha
    self.initialAlpha = params.initialAlpha
    self.finalAlpha = params.finalAlpha
    self.setupSpeed = params.speed

    self:initializeSpeedAndType()

    self.started = false

end

function FadeEffect:initializeSpeedAndType()

    if self.initialAlpha < self.finalAlpha then

        self.speed = self.setupSpeed
        self.type = 'On'

    else

        self.speed = -self.setupSpeed
        self.type = 'Off'

    end

end

function FadeEffect:update(dt)

    if self.started and self:isFinalAlpha() == false and self.type == 'On' then
     
        self:calculateAlpha(self.initialAlpha, self.finalAlpha, dt)

    else

        self:calculateAlpha(self.finalAlpha, self.initialAlpha, dt)

    end

end


function FadeEffect:calculateAlpha(min, max, dt)

    self.alpha = math.max(min, math.min(max, self.alpha + self.speed*dt))

end

function FadeEffect:getAlpha()
    return self.alpha
end

function FadeEffect:start()
    self.started = true
end

function FadeEffect:stop()
    self.started = false
end

function FadeEffect:reset()

    self.alpha = self.initialAlpha
    self.started = false

end

function FadeEffect:isFinalAlpha()

    if self.alpha == self.finalAlpha then
        return true
    else
        return false
    end

end

function FadeEffect:isInitialAplha()

    if self.alpha == self.initialAlpha then
        return true
    else
        return false
    end

end

function FadeEffect:wasStarted()
    return self.started
end

