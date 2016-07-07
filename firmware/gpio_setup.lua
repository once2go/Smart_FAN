
DHT=1

ROTATOR=0
ENGINE_LOW=5
ENGINE_MIDLE=6
ENGINE_HIGH=7

LED_R=1
LED_G=2
LED_B=3

BUTTON=4

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
	gpio.mode(LED_R, gpio.OUTPUT)
	gpio.mode(LED_G, gpio.OUTPUT)
	gpio.mode(LED_B, gpio.OUTPUT)
	
	gpio.write(ENGINE_LOW, gpio.LOW)
    gpio.write(ENGINE_MIDLE, gpio.LOW)
    gpio.write(ENGINE_HIGH, gpio.LOW)
    gpio.write(ROTATOR, gpio.LOW)	
	gpio.mode(BUTTON,gpio.INT,gpio.PULLUP)


IS_ROTATE=false
IS_POWER_ON=false
FAN_MODE=LOW_MODE