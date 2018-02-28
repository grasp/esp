

function read_hx(duration)

tmr.alarm(6, duration, 1, function()
-- user defined function: read from reg_addr content of dev_addr
print("i2c process")
--hx711.init(4,3)
end)

end

