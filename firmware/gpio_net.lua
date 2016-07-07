function getPowerOn()
	return '{"power":'..tostring(IS_POWER_ON)..'}'
end

function getSpeed()
	return '{"speed":'..tostring(FAN_MODE)..'}'
end

function getRotate()
	return '{"rotate":'..tostring(IS_ROTATE)..'}'
end

function getClimat()
	return read_t_h() 
end

function setSpeed(speed)
	set_mode(speed)
	return '{"speed":'..speed..'}'
end

function setRotate(rotate)
	set_rotate(rotate)
	return '{"rotate":'..tostring(rotate)..'}'
end 

function setPowerOn(power_on)
	set_power_on(power_on)
	return '{"power":'..tostring(power_on)..'}'
end

function getHelp()
	return '{"help":"  -lalal\n  -blabla \n -ololo \n"}'
end

dofile("ctrl_net.lua")