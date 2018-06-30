function [dataLength, serialNumber, matID, data, addr] = DataAnalyze(frame, byteNum, add)

dataLength = 0;
serialNumber = 0;
matID = 0;
data = 0;
addr = add;

% if length(frame) < 50
%     a=1;
% end

if length(frame) == 9%启动帧的应答帧
    
elseif length(frame) == 24
    addr = frame(2);
    mydialog(['当前盒子addr = ',num2str(addr)]);
    
elseif length(frame) > 1000 %数据帧

        dataLength       = frame(6) + frame(7)*256;
        serialNumber = frame(8) + frame(9)*256;
        matID        = frame(10);
        
        dataTemp = frame(11: end-2);
        try 
            if strcmp(byteNum, 'singleByte')
                data = dataTemp;
            elseif strcmp(byteNum, 'twoByte')
                
                dataTemp = reshape(dataTemp,2,[]);
                [a,b]=size(dataTemp);
                data = zeros(1,b);
                for i=1:b
                    data(i) = dataTemp(1,i) + dataTemp(2,i)*256;% 小端模式
                end
            end

        catch
            disp('reshape error')
        end
end