print("Connect to "..s_ssid..". Please wait")
wifi.setmode(wifi.STATION)
wifi.sta.config(s_ssid, s_passwd)
wifi.sta.connect()

cnt = 0
tmr.alarm(1, 3000, 1, function() 
if (wifi.sta.getip() == nil) and (cnt < 30) then 
    print("Wait...")
    cnt = cnt + 1 
else 
    tmr.stop(1)
    if (cnt < 30) then 
    	print("Config done, IP is "..wifi.sta.getip())
    else
		print("Can't connect to Router. Check your settings and try again")
	end 
	cnt = nil
	collectgarbage()
end 
end)



-- local cnt = 0
-- tmr.alarm(1, 3000, 1, function() 

-- if (wifi.sta.getip() == nil) and (cnt < 5) then 
--     print("Trying Connect to Router, Waiting...")
--     cnt = cnt + 1 
-- else 
--     tmr.stop(1)
--     if (cnt < 5) then print("Config done, IP is "..wifi.sta.getip())
-- else
-- 	print("Wifi setup time more than 15s, Please verify wifi.sta.config() function. Then re-download the file.")
-- end 
-- cnt = nil
-- collectgarbage()
-- end 
-- end)