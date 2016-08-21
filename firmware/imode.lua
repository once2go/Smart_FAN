wifi.setmode(wifi.SOFTAP)
cfg={}
cfg.ssid="I_am_smart_FAN"
cfg.pwd="11111111"
wifi.ap.config(cfg)
dofile("credset.lua")
print("Waiting for setup")