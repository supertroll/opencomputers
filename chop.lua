local rb = require("robot")

rb.swing()
rb.forward()
rb.select(1)

while rb.compareUp() do
    rb.swingUp()
    rb.up()
end
while not rb.detectDown() do
    rb.down()
end
rb.back()
