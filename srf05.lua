--trigger_pin=2
--echo_pin=1
--duration=3000

up_usec={}

function calculate_dis(rev_sec,send_sec,rev_usec,send_usec)

diff=rev_usec -  send_usec

if (diff >0 )
then 
print("diff=%s usec",diff)
else
diff=999999+rev_usec - send_usec
print("diff=%s usec",diff)
end


end

function trigger_srf(host,trigger_pin,echo_pin,duration)

send_sec,send_usec = 0,0

tmr.alarm(4, duration, 1, function()
report.send_count,report.rev_count = 0,0
gpio.mode(conf.trigger_pin, gpio.OUTPUT,gpio.PULLUP)
gpio.mode(conf.echo_pin, gpio.INPUT,gpio.PULLUP)
gpio.write(conf.trigger_pin,gpio.LOW)
tmr.delay(10)

--echo_pin_value=gpio.read(conf.echo_pin)
gpio.write(conf.trigger_pin,gpio.HIGH)
tmr.delay(20)
gpio.write(conf.trigger_pin,gpio.LOW)


--gpio.trig(conf.echo_pin, "up",function()
  --count=0
  report.echo_count=0
  
  --while(gpio.read(conf.echo_pin) == 0)
  --do
  -- report.send_count = report.send_count+1
  --end
  
  --report.send_sec, report.send_usec = rtctime.get()

  --while(gpio.read(conf.echo_pin) == 1)
  --do
   --report.rev_count = report.rev_count+1
  --end
  
  report.rev_sec, report.rev_usec = rtctime.get()

  calculate_dis(report.rev_sec,report.send_sec,report.rev_usec,report.send_usec)

  echo_pin_value=gpio.read(conf.echo_pin)
  --print("echo pin value2: %s",echo_pin_value)
  print("send:%s,rev count:",report.send_count,report.rev_count)
  print("send:%s %s,rev %s %s:",report.send_sec,report.send_usec, report.rev_sec,report.rev_usec)

 -- end)

  
--echo_pin_value=gpio.read(conf.echo_pin)

end)

end


function rev_echo()

--tmr.alarm(5, 10000, 1, function()

gpio.trig(conf.echo_pin, "down",function()

  rev_sec, rev_usec = rtctime.get()
  print("received: %s, %s,usec:%s,send usec:%s",rev_sec,report.send_sec,rev_usec,report.send_usec)
  if( rev_usec >0 and report.send_usec >0)
   then
   calculate_dis(rev_usec,report.send_usec)
  end
  gpio.mode(conf.echo_pin, gpio.INPUT)
end)
--end)
end
