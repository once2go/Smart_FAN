print("Hi I am smart FUN")
dofile("credentials.lua")
if s_ssid == nil or s_ssid == '' then 
  dofile("imode.lua")
else 
   if s_passwd == nil then s_passwd = '' end
   dofile("conmode.lua")
end