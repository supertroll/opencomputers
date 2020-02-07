require("mover")
local rb = require("robot")

local function check(upOrDown)
    if upOrDown == "up" then
	for i=9,15 do
	    rb.select(i)
	    if not rb.compareUp() then
		return true
	    end
	end
    elseif upOrDown == "down" then
	for i=9,15 do
	    rb.select(i)
	    if not rb.compareDown() then
		return true
	    end
	end
    else
	for i=9,15 do
	    rb.select(i)
	    if not rb.compare() then
		return true
	    end
	end
    end
    return false
end

local function roundCheck()
    if check("up") then
	rb.swingUp()
    end

    if check("down") then
	rb.swingDown()
    end
    
    rb.turnLeft()
    if check("") then
	rb.swing()
    end

    rb.turnAround()
    if check("") then
	rb.swing()
    end
    rb.turnLeft()
end


local function forwardStep(overrideAmount)
    if check("") or overrideAmount > 0 then
	local goneF=goneForward + 1
	roundCheck()
	rb.swing()
	rb.forward()
	forwardStep(overrideAmount - 1)
    else
	roundCheck()
	move(goneForward.."b")
	rb.select(1)
	rb.place()
	goneForward = 0
    end
end
