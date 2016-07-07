file.remove("credentials.lua")
file.open("credentials.lua","w+")
temp = "s_ssid = \""..n_ssid.."\""
file.writeline(temp)
temp = "s_passwd = \""..n_passwd.."\""
file.writeline(temp)
file.flush()
temp = nil
file.close()
node.restart()