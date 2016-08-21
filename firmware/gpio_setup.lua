
DHT=2

ROTATOR=0
ENGINE_LOW=5
ENGINE_MIDLE=6
ENGINE_HIGH=7

BUTTON=4

NET_INDICATOR = 8

BUTTON_DELAY=10000
SWITCHING_MODE_DELAY=5000

LOW_MODE=435
MED_MODE=436
HIGH_MODE=437

is_handling=false

	gpio.mode(ROTATOR, gpio.OUTPUT)
	gpio.mode(ENGINE_LOW, gpio.OUTPUT)
	gpio.mode(ENGINE_MIDLE, gpio.OUTPUT)
	gpio.mode(ENGINE_HIGH, gpio.OUTPUT)
	gpio.mode(NET_INDICATOR, gpio.OUTPUT)
	
	gpio.write(ENGINE_LOW, gpio.LOW)
    gpio.write(ENGINE_MIDLE, gpio.LOW)
    gpio.write(ENGINE_HIGH, gpio.LOW)
    gpio.write(ROTATOR, gpio.LOW)
    gpio.write(NET_INDICATOR, gpio.LOW)
	gpio.mode(BUTTON,gpio.INT,gpio.PULLUP)


IS_ROTATE=false
IS_POWER_ON=false
FAN_MODE=LOW_MODE