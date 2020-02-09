local rb = require("robot")

rb.swing()
rb.forward()

while rb.detectUp() do
    rb.swingUp()
    rb.up()
end
while not rb.detectDown() do
    rb.down()
end
rb.back()
