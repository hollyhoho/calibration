function pressure  = Voltage2Pressure(voltage)
k1 = 0.0420;
k2 = 0.0195;
% m1 = 20;
m2 = 192;

if voltage <= 358
    pressure = (voltage)/k1;
else
    pressure = (voltage - m2)/k2;
end

