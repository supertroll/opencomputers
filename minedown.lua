rb = require("robot")
shell = require("shell")

arg = shell.parse(...)

seq = {rb.swing,rb.forward,rb.swingUp,rb.swingDown,rb.down}
retSeq = {rb.up,rb.forward}

function goBack(amount)
    rb.turnAround()
    for i=1,amount do
	for j in pairs(retSeq) do
	    retSeq[j]()
	end
    end
    return
end

for i=1,tonumber(arg[1]) do
    for j in pairs(seq) do
	if not seq[j]() then
	    goBack(i)
	    return
	end
    end
end
	
