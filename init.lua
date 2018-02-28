require "wi_fi"
require "http_agent"
require "http_post"
require "read_dht11"
require "srf05"


--global variable
 wifi_connect_tried = 0
 conf = 
      {         
         dht11_pin=5,
         trigger_pin=2,
         echo_pin=1,
         dht_interval=10000,
         default_wifi="qiqi_shufang_2",
         default_password="11102008",
         default_host="192.168.3.100:3000"

         --default_wifi="qiqi_shufang",
         --default_password="11102008",
         --default_host="192.168.0.100:3000"
         
         --default_wifi="iPhone",
         --default_password="12345678",
         --default_host="172.20.10.2:3000"

         --default_wifi="maojiawu_2F",
         --default_password="232232232",
         --default_host="192.168.8.164:3000"
         
       }

   report ={
   
           chip_id=0,
           flash_id=0,
           temperature=0,
           humidity=8,
           send_sec=0,
           send_usec=0,
           rev_sec=0,
           rev_usec=0,
           send_count=0,
           rev_count=0
           
         }
    



-- Config
local pin = 4            --> GPIO2
local value = gpio.LOW
local duration = 2000    --> 1 second
data_list={}
-- Function toggles LED state
function toggleLED()
    print("toggle led")
    if value == gpio.LOW then
        print("value is low")
        value = gpio.HIGH
    else
       print("value is high")
       value = gpio.LOW
    end
    
    gpio.write(pin, value)
end

gpio.mode(pin, gpio.OUTPUT)

-- Create an interval
--tmr.alarm(0,duration,1,function()
--  toggleLED()
--end)

gpio.mode(conf.trigger_pin, gpio.OUTPUT)
gpio.mode(conf.echo_pin, gpio.INT)
gpio.write(conf.echo_pin,gpio.LOW)

init_wifi(conf.default_wifi,conf.default_password)

register_device(conf.default_host)

read_dht(conf.default_host,conf.dht11_pin,conf.dht_interval)

http_post_data()

--trigger_srf(conf.default_host,conf.trigger_pin,conf.echo_pin,10000)
--rev_echo()




