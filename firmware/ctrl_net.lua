response = ""
sv=net.createServer(net.TCP, 30)
     sv:listen(9898,function(c)
     c:on("receive", function(c, pl)
     t = cjson.decode(pl)
     for k,v in pairs(t) do
     if( k == "help_get") and ( v == 1) then 
          response = getHelp()
     end

     if( k == "power_get") and ( v == 1) then 
          response = getPowerOn()
     end

     if( k == "speed_get") and ( v == 1) then 
          response = getSpeed()
     end

     if( k == "climat_get") and ( v == 1) then 
          response = getClimat()
     end

     if( k == "rotate_get") and ( v == 1) then 
          response = getRotate()
     end

     if( k == "power_set") then 
          response = setPowerOn(v)
     end

     if( k == "speed_set") then 
          response = setSpeed(v)
     end

     if( k == "rotate_set") then 
          response = setRotate(v)
     end
     end
     if response == '' then response = '{"status":"Unknown command"}' end 
     c:send(response)
     end)
     c:send("Connected")
end)
