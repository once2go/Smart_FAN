
function save_settings()
	dofile("write_setngs.lua")
end

function set_rotate(rotate)
	if rotate == true then
	    if IS_POWER_ON == true then
	  		 gpio.write(ROTATOR, gpio.HIGH)
	    end
	else
	   gpio.write(ROTATOR, gpio.LOW)
	end
	IS_ROTATE = rotate
	save_settings() 
end

function set_mode(mode)
  gpio.write(ENGINE_LOW, gpio.LOW)
  gpio.write(ENGINE_MIDLE, gpio.LOW)
  gpio.write(ENGINE_HIGH, gpio.LOW)
  tmr.delay(SWITCHING_MODE_DELAY)
  if IS_POWER_ON == true then 
	  if mode == LOW_MODE then
		 gpio.write(ENGINE_LOW, gpio.HIGH)
	  end 

	  if mode == MED_MODE then
		 gpio.write(ENGINE_MIDLE, gpio.HIGH)
	  end 

	  if mode == HIGH_MODE then
		 gpio.write(ENGINE_HIGH, gpio.HIGH)
	  end
  end
  FAN_MODE = mode 
  save_settings() 
end

function set_power_on(is_pow_on)
	if is_pow_on == true then 
		IS_POWER_ON = true
		set_rotate(IS_ROTATE)
		set_mode(FAN_MODE)
	else
		gpio.write(ENGINE_LOW, gpio.LOW)
        gpio.write(ENGINE_MIDLE, gpio.LOW)
        gpio.write(ENGINE_HIGH, gpio.LOW)
        gpio.write(ROTATOR, gpio.LOW)
 	    IS_POWER_ON= false 
	end
	save_settings() 
end


function hard_on_off()
	is_handling = true 
	if IS_POWER_ON == true then 
        set_power_on(false)
	else 
		set_power_on(true)
	end 
	tmr.delay(BUTTON_DELAY)
	is_handling = false
end 

function handle_interupt()
	if is_handling == false then hard_on_off() end 
end

function read_t_h() 
resp = ''
status, temp, humi, temp_dec, humi_dec = dht.read(DHT)
if status == dht.OK then
        resp = '{"data":{"temp":'..temp..', "hum":'..humi..'}}'
	elseif status == dht.ERROR_CHECKSUM then
	    resp = "DHT Checksum error."
	elseif status == dht.ERROR_TIMEOUT then
	    resp = "DHT timed out." 
	end
	print(resp)
	return resp
end

gpio.trig(BUTTON, "down", handle_interupt)

l = file.list();
for k,v in pairs(l) do
  if k == "settings.lua" then dofile("settings.lua") end
end
set_power_on(IS_POWER_ON)
set_mode(tonumber(FAN_MODE))
set_rotate(IS_ROTATE)

