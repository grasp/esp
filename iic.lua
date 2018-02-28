
function read_hx(duration)

tmr.alarm(6, duration, 1, function()
-- user defined function: read from reg_addr content of dev_addr
print("i2c process")
hx711.init(3,4)
raw_data = hx711.read(0)
print(raw_data)
end)

end
