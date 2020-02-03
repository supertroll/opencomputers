rb = require("robot")
shell = require("shell")
require("mover")

arg = shell.parse(...)

function mine3x3()
    rb.swing()
    rb.forward()
    rb.turnRight()
    rb.swing()
    rb.turnAround()
    rb.swing()
    rb.turnRight()
    for i=1,2 do
	rb.swingUp()
	rb.up()
	rb.turnRight()
	rb.swing()
	rb.turnAround()
	rb.swing()
	rb.turnRight()
    end
    move("2d")
end

if arg[1] ~= nil then
    for i=1,arg[1] do
	mine3x3()

    end
    for i=1,arg[1] do
	print(arg[1] - i .. " left")
	rb.back()
    end
else
    mine3x3()
end

