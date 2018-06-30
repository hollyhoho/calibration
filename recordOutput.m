function recordOutput(whichHalf, pressurePoint, data, savefilename)
    global pressureSum
    global count
    global calInfo
    global calInfoFile
    
    array = reshape(data, 32, 32);
    
    pressureSum = pressureSum + array;
    
    if count == 100
        pressureMean = pressureSum./100;
        if strcmp(whichHalf, 'close')
            begin = 1;
            stop = 16;
        elseif strcmp(whichHalf, 'far')
            begin = 17;
            stop = 32;
        end
        
        output = calInfo.output;
        for i = begin:stop
            for j = 1:32
                temp = output{i,j};
                temp(pressurePoint+1) = pressureMean(i,j);
                output{i,j} = temp;
            end
        end
        calInfo.output = output;
        
       save(calInfoFile, 'calInfo');
       mydialog('数据记录完成')
    end
    
    
    
end