file.remove("credentials.lua")
file.open("credentials.lua","w+")
temp = "s_ssid = \""..n_ssid.."\""
file.writeline(temp)
temp = "s_passwd = \""..n_passwd.."\""
file.writeline(temp)
file.flush()
temp = nil
file.close()





-- then restart module 


t = cjson.decode('{"credentials":"{"n_ssid":"value"}"}')
for k,v in pairs(t) do print("Key is: "..k.. " and value is: "..v) end