Scene = {}

function Scene.start(data)
    print("length:",#data.devices)
    for i,v in ipairs(data.devices) do
	   local deviceid = tonumber(v.enumber,16)
	   local deviceType = tonumber(v.htype,16)
	   --switch
	   if v.isPoweron == 1 or v.poweron == 1 or v.swithon == 1 or v.unlock == 1 or v.pushing == 1 or v.showed == 1 or v.waiting == 1 then
		  print("on:",deviceid)
		  local device = Device:create()
		  if deviceType == device.BGMUSIC then
			 device:bgMusicON(deviceid,C4:RoomGetId())
		  elseif deviceType == device.AMPLIFIER then
			 device:switchAmplifier(deviceid,v.waiting)
		  else
			 C4:SendToDevice(deviceid,"ON",{})
		  end
	   end
	   
	   if v.isPoweron == 0 or v.poweron == 0 or v.swithon == 0 or v.pushing == 0 or v.showed == 0 or v.waiting == 0 then
		  if deviceType == device.AMPLIFIER then
			 device:switchAmplifier(deviceid,v.waiting)
		  else
			 C4:SendToDevice(deviceid,"OFF",{})
		  end
	   end
	   
	   --light
	   if v.brightness then
		  C4:SendToDevice(deviceid,"RAMP_TO_LEVEL", {LEVEL = v.brightness, TIME = 1000})
	   end
	   
	   if v.color and #v.color>0 then
		  C4:SendToDevice(deviceid,"SET_BUTTON_COLOR", {ON_COLOR = string.format("%2x%2x%2x",v.color[1],v.color[2],v.color[3])})
	   end
	   
	   --blind
	   if v.openvalue then
		  
	   end
	   
	   --TV
	   if v.volume then
		  C4:SendToDevice(deviceid,"SET_VOLUME_LEVEL",{LEVEL = v.volume})
	   end
	   
	   if v.channelID then
		  
	   end
	   
	   --DVD
	   if v.dvolume then
		  C4:SendToDevice(deviceid,"SET_VOLUME_LEVEL",{LEVEL = v.dvolume})
	   end
	   
	   --bgmusic
	   if v.bgvolume then
		  C4:SendToDevice(deviceid,"SET_VOLUME_LEVEL",{LEVEL = v.bgvolume})
	   end
    end
end

function Scene.stop(data)
	for i,v in ipairs(data.devices) do
		local deviceid = tonumber(v.enumber,16)
		C4:SendToDevice(deviceid,"OFF",{})
	end
end