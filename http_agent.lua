--some statistic for http request
http_request_fail = 0
http_request_succ = 0

function register_device(host)
 chipid = node.chipid()
 
 tmr.alarm(2, 10000, 1, function()
    http.get(string.format("http://%s/devices/heartbeat/%s",host,chipid),nil,function(code, data)
    
      if (code < 1) then
        print("HTTP request failed")
        http_request_fail = http_request_fail + 1
       
      else
        --change interva to 500 seconds to register
        tmr.interval(2,5000)
  
        
        t = cjson.decode(data)
        print("code=%s, response=%s",code,t["response"])
        --print(t["csrf"])
        _G["csrf"] = t["csrf"]
        
        rtctime.set(t["time"],0)
       
        
        http_request_succ = http_request_succ + 1
        tmr.stop(2)
      end
      
  end)
 
 end)
end




--register_device("192.168.0.101:3000")



