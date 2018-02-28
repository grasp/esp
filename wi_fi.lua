--input wifi name and password
--return IP address or nil
function init_wifi(default_wifi,default_password)

    wifi.setmode(wifi.STATION)
    wifi.sta.config(default_wifi,default_password)
    wifi.sta.connect()
 tmr.alarm(1, 1000, 1, function()
  if wifi.sta.getip()== nil then
    wifi_connect_tried =  wifi_connect_tried + 1
    print("IP unavaiable, Waiting...wifi_connect_tried=",wifi_connect_tried)
    -- shall we reboot the devices if tried too many times?
  else
   tmr.stop(1)
   -- change to 5 minutes to check wifi
   tmr.interval(1, 300000)
   ip_address = wifi.sta.getip()
   --print("ESP8266 mode is: " .. wifi.getmode())
   --print("The module MAC address is: " .. wifi.ap.getmac())
   print("Config Wifi done, IP is "..wifi.sta.getip())

   return ip_address
 -- dofile ("domoticz.lua")
 end
 end)

end


