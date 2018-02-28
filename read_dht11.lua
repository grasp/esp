local read_succ = 0
local read_fail_checksum = 0
local read_timeout = 0



function read_dht(host,pin,duration)

  tmr.alarm(3, duration, 1, function()
    status, temp, humi, temp_dec, humi_dec = dht.read(pin)
    sec_time,msec_time = rtctime.get()
    if status == dht.OK  and   sec_time >0 then
        -- Integer firmware using this example
        --print(rtctime.get())
        --print(string.format("DHT Temperature:%d.%03d;Humidity:%d.%03d\r\n",
        --      math.floor(temp),
        --      temp_dec,
        --      math.floor(humi),
        --      humi_dec
        --))

        read_succ = read_succ +1
       
        -- Float firmware using this example
        print("DHT Temperature2:"..temp..";".."Humidity:"..humi.." temp_dec:"..temp_dec)
        post_temperature_data(host,sec_time,temp,humi)
    elseif status == dht.ERROR_CHECKSUM then
        print( "DHT Checksum error." )
        read_fail_checksum = read_fail_checksum + 1
        
    elseif status == dht.ERROR_TIMEOUT then
        print( "DHT timed out." )
        read_timeout = read_timeout + 1
    elseif sec_time  == 0 then
       print "we could not got rtc time from server"
    end

  end)
end

function post_temperature_data(host,sec_time,temp,humi)
t={}
t["time"]=sec_time
t["temp"]=temp
t["humi"]=humi
t["authenticity_token"]=_G["csrf"]
data_string = string.format('{"time":%s,"temp":%s,"humi":%s}',sec_time,temp,humi)
print("data_string"..data_string)
chipid = node.chipid()
http.get(string.format("http://%s/devices/post_data/%s/%s/%s",host,chipid,temp,humi),
  --'Content-Type: application/json\r\n',
 nil,
-- cjson.encode(data_string),
  function(code, data)
    if (code < 0) then
      print("HTTP request failed")
    else
      print(code, data)
    end
  end)

end



