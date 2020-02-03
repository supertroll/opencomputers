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
	for i=12,15 do
	    rb.select(i)
	    if rb.compareUp() then
		return true
	    end
	end
    elseif upOrDown == "down" then
	for i=12,15 do
	    rb.select(i)
	    if rb.compareDown() then
		return true
	    end
	end
    else
	for i=12,15 do
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
    end

    if check("down") and currentOffset > down then
	down = currentOffset
    end
    
    rb.turnLeft()
    if check("") and currentOffset > left then
	left = currentOffset
    end

    rb.turnAround()
    if check("") and currentOffset > right then
	right = currentOffset
    end
    rb.turnLeft()
end


function forwardStep(overrideAmount)
    print(up .. "," .. down .. "," .. left .. "," .. right)
    if check("") or overrideAmount > 0 then
	goneForward = goneForward + 1
	roundCheck(goneForward)
	rb.swing()
	rb.forward()
	forwardStep(overrideAmount - 1)
    else
	roundCheck(goneForward)
	for i=1,goneForward do
	    move("b")
	    rb.select(1)
	    rb.place()
	end
	goneForward = 0
    end
end

function leftStep()
    rb.turnLeft()
    rb.swing()
    rb.forward()
    rb.turnRight()
    LROffset = LROffset + 1
    Oleft = left
    left = 0
    forwardStep(Oleft)
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
    Oright = right
    right = 0
    forwardStep(Oright)
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
    Oup = up
    up = 0
    forwardStep(Oup)
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
    Odown = down
    down = 0
    forwardStep(Odown)
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
    forwardStep(1)
    leftStep()
    rightStep()
    upStep()
    downStep()
end

main()
