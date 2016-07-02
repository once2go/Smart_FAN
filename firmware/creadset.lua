ready = false
response = ""
sv=net.createServer(net.TCP, 30)
	sv:listen(9899,function(c)
     c:on("receive", function(c, pl)
	 t = cjson.decode(pl)
     for k,v in pairs(t) do 
     if( k == "credentials") and ( v == "set") then 
     	 ready = true
		 response = '{"status":"OK"}'
     end
     if ready and ( k == "ssid") then 
     	if (v == nil) or (v == '') then 
     		response = '{"status":"SSID not correct"}'
     	else 
     	    n_ssid = v
		    response = '{"status":"OK"}'
		end
     end
     if ready and ( k == "password") then 
     	n_passwd = v
		response = '{"status":"OK"}'
     end
     if ready and ( k == "config") then 
     	if v then 
     		dofile("conmode.lua")
     	else 
     		dofile("init.lua")
     		end
     end
     if response == '' then response = '{"status":"Unknown command"}' end 
     end
     c:send(response)
     end)
     c:send("Connected")
end)
