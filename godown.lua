rb = require("robot")
shell = require("shell")

arg = shell.parse(...)

seq = {rb.forward,rb.down}

if arg[1] ~= nil then
    for j=0,arg[1] do
	for i in pairs(seq) do
	    seq[i]()
	end
    end
else
    seq[1]()
    seq[2]()
end
