local cp = require("computer")
local cmp = require("component")
local rb = require("robot")

local moves = {
    f = rb.forward,
    b = rb.back,
    u = rb.up,
    d = rb.down,
    l = rb.turnLeft,
    r = rb.turnRight
}

function move(movement)
    for step in string.gmatch(movement,"%d*%a") do
	local amount = string.match(step, "%d+") or 1
	local move = string.match(step,"%a")
	for i=1,amount do
	    moves[move]()
	end
	refuel()
    end
end

function refuel()
    if cp.energy() < (cp.maxEnergy() / 10) and cmp.generator.count() == 0 then
	rb.select(16)
	cmp.generator.insert(rb.count() - 1)
    end
end
