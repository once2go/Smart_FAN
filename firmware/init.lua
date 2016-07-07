dofile("gpio_setup.lua")
dofile("gpio_ctrl.lua")
is_credentials_exist=false
l = file.list();
for k,v in pairs(l) do
  if k == "credentials.lua" then is_credentials_exist=true end
end
if is_credentials_exist then 
	print("Credential exist") 
else
	n_ssid=''
	n_passwd=''
	dofile("writecred.lua");
end

print("Hi I am smart FUN")
dofile("credentials.lua")
if s_ssid == nil or s_ssid == '' then 
   dofile("imode.lua")
else 
   if s_passwd == nil then s_passwd = '' end
   dofile("conmode.lua")
end






 