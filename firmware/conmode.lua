print("Connect to "..s_ssid..". Please wait")
wifi.setmode(wifi.STATION)
wifi.sta.config(s_ssid, s_passwd)
wifi.sta.connect()


value = true
function indicate(isIndicate)
    if isIndicate == true then   
        tmr.alarm(2, 500, 1, function ()
            gpio.write(NET_INDICATOR, value and gpio.HIGH or gpio.LOW)
            value = not value
        end)
    else 
        tmr.stop(2)
    end
end


indicate(true)
cnt = 0
tmr.alarm(1, 3000, 1, function() 
if (wifi.sta.getip() == nil) and (cnt < 5) then 
    print("Wait...")
    cnt = cnt + 1 
else 
    tmr.stop(1)
    indicate(false)
    if (cnt < 5) then 
    	print("Config done, IP is "..wifi.sta.getip())
        gpio.write(NET_INDICATOR, gpio.HIGH)
        dofile("gpio_net.lua")
    else
		dofile("imode.lua")
        gpio.write(NET_INDICATOR, gpio.LOW)
	end 
	cnt = nil
	collectgarbage()
end 
end)

