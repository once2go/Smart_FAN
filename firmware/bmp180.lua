 OSS = 1 
 ADDR = 0x77 
 REG_CALIBRATION = 0xAA
 REG_CONTROL = 0xF4
 REG_RESULT = 0xF6

 COMMAND_TEMPERATURE = 0x2E
 COMMAND_PRESSURE = {0x34, 0x74, 0xB4, 0xF4}

 AC1=0
 AC2=0
 AC3=0
 AC4=0
 AC5=0
 AC6=0
 B1=0
 B2=0
 MB=0
 MC=0
 MD=0

 bmp180_t=0
 bmp180_p=0

 bmp180_is_init = false


 bmp180_id = 0


 function twoCompl(value)
 if value > 32767 then value = -(65535 - value + 1)
 end
 return value
end


 function read_reg(reg_addr, length)
  i2c.start(bmp180_id)
  i2c.address(bmp180_id, ADDR, i2c.TRANSMITTER)
  i2c.write(bmp180_id, reg_addr)
  i2c.stop(bmp180_id)
  i2c.start(bmp180_id)
  i2c.address(bmp180_id, ADDR,i2c.RECEIVER)
  c = i2c.read(bmp180_id, length)
  i2c.stop(bmp180_id)
  return c
end


 function write_reg(reg_addr, reg_val)
  i2c.start(bmp180_id)
  i2c.address(bmp180_id, ADDR, i2c.TRANSMITTER)
  i2c.write(bmp180_id, reg_addr)
  i2c.write(bmp180_id, reg_val)
  i2c.stop(bmp180_id)
end


function bmp180_init(sda, scl)
  i2c.setup(bmp180_id, sda, scl, i2c.SLOW)
  local calibration = read_reg(REG_CALIBRATION, 22)

  AC1 = twoCompl(string.byte(calibration, 1) * 256 + string.byte(calibration, 2))
  AC2 = twoCompl(string.byte(calibration, 3) * 256 + string.byte(calibration, 4))
  AC3 = twoCompl(string.byte(calibration, 5) * 256 + string.byte(calibration, 6))
  AC4 = string.byte(calibration, 7) * 256 + string.byte(calibration, 8)
  AC5 = string.byte(calibration, 9) * 256 + string.byte(calibration, 10)
  AC6 = string.byte(calibration, 11) * 256 + string.byte(calibration, 12)
  B1 = twoCompl(string.byte(calibration, 13) * 256 + string.byte(calibration, 14))
  B2 = twoCompl(string.byte(calibration, 15) * 256 + string.byte(calibration, 16))
  MB = twoCompl(string.byte(calibration, 17) * 256 + string.byte(calibration, 18))
  MC = twoCompl(string.byte(calibration, 19) * 256 + string.byte(calibration, 20))
  MD = twoCompl(string.byte(calibration, 21) * 256 + string.byte(calibration, 22))

  bmp180_is_init = true
end


 function read_temp()
  write_reg(REG_CONTROL, COMMAND_TEMPERATURE)
  tmr.delay(5000)
local dataT = read_reg(REG_RESULT, 2)

  UT = string.byte(dataT, 1) * 256 + string.byte(dataT, 2)
  local X1 = (UT - AC6) * AC5 / 32768
  local X2 = MC * 2048 / (X1 + MD)
  B5 = X1 + X2
  bmp180_t = (B5 + 8) / 16
  return(t)
end

 function read_pressure(oss)
  write_reg(REG_CONTROL, COMMAND_PRESSURE[oss + 1]);
  tmr.delay(30000);
  local dataP = read_reg(0xF6, 3)
  local UP = string.byte(dataP, 1) * 65536 + string.byte(dataP, 2) * 256 + string.byte(dataP, 1)
  UP = UP / 2 ^ (8 - oss)
  local B6 = B5 - 4000
  local X1 = B2 * (B6 * B6 / 4096) / 2048
  local X2 = AC2 * B6 / 2048
  local X3 = X1 + X2
  local B3 = ((AC1 * 4 + X3) * 2 ^ oss + 2) / 4
  X1 = AC3 * B6 / 8192
  X2 = (B1 * (B6 * B6 / 4096)) / 65536
  X3 = (X1 + X2 + 2) / 4
  local B4 = AC4 * (X3 + 32768) / 32768
  local B7 = (UP - B3) * (50000/2 ^ oss)
  bmp180_p = (B7 / B4) * 2
  X1 = (bmp180_p / 256) * (bmp180_p / 256)
  X1 = (X1 * 3038) / 65536
  X2 = (-7357 * bmp180_p) / 65536
  bmp180_p = bmp180_p +(X1 + X2 + 3791) / 16
  return (bmp180_p)
end

function bmp180_read(oss)
  if (oss == nil) then
     oss = 0
  end
  if (not bmp180_is_init) then
     print("init() must be called before read.")
  else  
     read_temp()
     read_pressure(oss)
  end
end;

function bmp180_getTemperature()
	     bmp180_read(OSS)
  return bmp180_t
end

function bmp180_getPressure()
		 bmp180_read(OSS)
  return bmp180_p
end


