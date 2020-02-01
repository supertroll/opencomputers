require("mover")
local rb = require("robot")

local movementBack = ""
local up = 0
local down = 0
local right = 0
local left = 0
local goneForward = 0
local LROffset = 0
local UDOffset = 0

function check(upOrDown)
    if upOrDown == "up" then
	for i=13,16 do
	    rb.select(i)
	    if rb.compareUp() then
		return true
	    end
	end
    elseif upOrDown == "down" then
	for i=13,16 do
	    rb.select(i)
	    if rb.compareDown() then
		return true
	    end
	end
    else
	for i=13,16 do
	    rb.select(i)
	    if rb.compare() then
		return true
	    end
	end
    end
    return false
end

function roundCheck(currentOffset)
    if check("up") and currentOffset > up then
	up = currentOffset
    elseif up > currentOffset then
	up = 0
    end

    if check("down") and currentOffset > down then
	down = currentOffset
    elseif down > currentOffset then
	down = 0
    end
    
    rb.turnLeft()
    if check("") and currentOffset > left then
	left = currentOffset
    elseif left > currentOffset then
	left = 0
    end

    rb.turnAround()
    if check("") and currentOffset > right then
	right = currentOffset
    elseif right > currentOffset then
	right = 0
    end
    rb.turnLeft()
end


function forwardStep(overrideAmount)
    if check("") or overrideAmount > 0 then
	goneForward = goneForward + 1
	rb.swing()
	rb.forward()
	roundCheck(goneForward)
	forwardStep(overrideAmount - 1)
    else
	move(goneForward .. "b")
	goneForward = 0
    end
end

function leftStep()
    rb.turnLeft()
    rb.swing()
    rb.forward()
    rb.turnRight()
    LROffset = LROffset + 1
    forwardStep(left)
    if left > 0 then
	leftStep()
    else
	move("l"..LROffset.."br")
	LROffset = 0
    end
end

function rightStep()
    rb.turnRight()
    rb.swing()
    rb.forward()
    rb.turnLeft()
    LROffset = LROffset + 1
    forwardStep(right)
    if right > 0 then
	rightStep()
    else
	move("r"..LROffset.."bl")
	LROffset = 0
    end
end

function upStep()
    rb.swingUp()
    rb.up()
    UDOffset = UDOffset + 1
    forwardStep(up)
    leftStep()
    rightStep()
    if up > 0 then
	upStep()
    else
	move(UDOffset.."d")
	UDOffset = 0
    end
end

function downStep()
    rb.swingDown()
    rb.down()
    UDOffset = UDOffset + 1
    forwardStep(down)
    leftStep()
    rightStep()
    if down > 0 then
	downStep()
    else
	move(UDOffset.."u")
	UDOffset = 0
    end
end

function main()
    rb.swing()
    rb.forward()
    forwardStep(0)
    upStep()
    downStep()
end

main()
