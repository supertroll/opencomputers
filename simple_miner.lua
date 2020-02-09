require("mover")

local rb = require("robot")

local goneForward = 0

local function check(upOrDown)
    if upOrDown == "up" then
	for i=9,15 do
	    rb.select(i)
	    if rb.compareUp() then
		return false
	    end
	end
    elseif upOrDown == "down" then
	for i=9,15 do
	    rb.select(i)
	    if rb.compareDown() then
		return false
	    end
	end
    else
	for i=9,15 do
	    rb.select(i)
	    if rb.compare() then
		return false
	    end
	end
    end
    return true
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

local function invCheck()
    for i=1,16 do
	if rb.count(i) == 0 then
	    return true
	end
    end
    return false
end


local function forwardStep(overrideAmount)
    if check("") or overrideAmount > 0 and invCheck() then
	goneForward = goneForward + 1
	roundCheck()
	rb.swing()
	move("f")
	forwardStep(overrideAmount - 1)
    else
	roundCheck()
	move(goneForward.."b")
	rb.select(1)
	rb.place()
	goneForward = 0
    end
end

forwardStep(...)
