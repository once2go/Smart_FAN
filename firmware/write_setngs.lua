file.remove("settings.lua")
file.open("settings.lua","w+") 
temp = "IS_ROTATE = \""..tostring(IS_ROTATE).."\""
file.writeline(temp)
temp = "IS_POWER_ON = \""..tostring(IS_POWER_ON).."\""
file.writeline(temp)
temp = "FAN_MODE = \""..FAN_MODE.."\""
file.writeline(temp)
file.flush()
temp = nil
file.close()

