print("Settup init mode")
file.remove("ssid.lua")
file.remove("password.lua")
wifi.setmode(wifi.SOFTAP)
cfg={}
cfg.ssid="I_am_smart_FAN1"
cfg.pwd="11111111"
wifi.ap.config(cfg)
dofile("waitset.lua")
print("Waiting for setup")