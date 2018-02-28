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

--gpio.mode(conf.trigger_pin, gpio.OUTPUT)
--gpio.mode(conf.echo_pin, gpio.INT)
--gpio.write(conf.echo_pin,gpio.LOW)