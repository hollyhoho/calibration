function calculateSlope(calInfo, calInfoFile)
    output = calInfo.output;
    slope = calInfo.slope;
    
    pressurePoint = [0, 8, 16, 24, 32];
    
    for i =1:32
        for j=1:32
            temp_s = slope{i,j};
            temp_o = output{i,j};
            
            for k = 1 : length(temp_o)-1
                Ax = pressurePoint(k);
                Ay = temp_o(k);
                Bx = pressurePoint(k+1);
                By = temp_o(k+1);
                temp_s(k, 1 ) = (By - Ay)/(Bx - By);
                temp_s(k, 2 ) = Ay - temp_s(k, 1 )*Ax;
            end          
            slope{i,j} = temp_s;
        end
    end
    calInfo.slope = slope;
    save(calInfoFile, 'calInfo');
    mydialog('系数计算完成');
end