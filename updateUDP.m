    function updateUDP(obj,event,handles)%正式方法定义 
    testFlag = false;

%     function updateUDP(data, testFlag, serialNumber )%测试专用方法定义
    edgeLength = 32;
    global udpReceive
    global saveFlag
    global savePathFile
    global human_pressure_frame
    global lastState
    global meshFlag
    global addr
    global count
    global whichHalf
    global pressurePoint
    global calibrationFlag
    global savefilename

    human_pressure_frame = zeros(70,160);
    lastState = 'unknown';

    if ~testFlag
        %     frame = fscanf(udpReceive);%文本方式读
        frame = fread(udpReceive);%二进制方式读
%         [frameLength, serialNumber, matID, data, addr] = DataAnalyze(frame, 'twoByte');
         [frameLength, serialNumber, matID, data, addr] = DataAnalyze(frame, 'singleByte', addr);
    end
    
    mean(data)
    
    dataLength = length(data);
    if dataLength == 1024
        if ~isempty(count)
        if count <= 100 && calibrationFlag
            recordOutput(whichHalf, pressurePoint, data, savefilename);
            count = count +1
        end
        if count > 100   
            calibrationFlag = false;
            count = 0;
        end
        end
        
        %%
        data = reshape(data,edgeLength,edgeLength);
        
        data = data';
            human_pressure_frame = ReshapeArray.reshapeArray(data, 'iFly_201806');
        handles=get(gcf,'userdata');    
        data = data';
            if meshFlag
               mesh(data)
               axis([1 32 1 32 0 300])
            else
%               human_pressure_frame = imresize(human_pressure_frame, 8., 'bicubic');
%               human_pressure_frame = filter2(fspecial('gaussian'),human_pressure_frame)/255;
              clims=[0 80];
              imagesc(human_pressure_frame,clims);
              axis image            
            end
            
            if saveFlag
                fid = fopen(savePathFile, 'a+'); 
                fprintf(fid,'%3d ',reshape(data, 1, [])); 
                fprintf(fid, '\n');
                fclose(fid); 
            end
    end