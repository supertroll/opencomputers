local cmp = require("component")
local rb = require("robot")

while true do
    if(rb.detect() or rb.detectUp()) then
	if not rb.swing() then
	    while not rb.detectDown() do
		rb.down()
	    end
	elseif not rb.up() then
	    rb.swingUp()
	    rb.up()
	end
    else
	while not rb.detectDown() do
	    rb.down()
	end
	return
    end
end

