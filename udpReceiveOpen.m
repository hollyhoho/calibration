function u = udpReceiveOpen(port2receive, handles)

global handles
global udpReceive
global errCount
global initaialFrameCount
global dataSum
global x
global y
global z
global t
global tt
t=0;
tt=0;

global meshFlag
global algoFlag
global initialFlag

global laySitRecord
global onOffRecord
global onOffArray
global moveOrNotRecord
global moveOrNotArray
global movementTemp
global movement
global frame_no
global t_movement
global secNum
global secLength
global meanFrame

global savefile

dataSum = zeros(32, 32);
errCount = 0;
initaialFrameCount = 0;
[x,y,z] = peaks(16);

algoFlag = true;
initialFlag =false;
savefile = 'data';

secNum = 6;
secLength = 25;
laySitRecord = cell(secLength,1);
onOffRecord = cell(secLength,1);
onOffArray = cell(secLength, secNum);
moveOrNotRecord = cell(secLength,1);
moveOrNotArray = cell(secLength, secNum);
movementTemp = cell(secLength,1);
movement = cell(secLength,secNum);
frame_no = 1;
t_movement = 1;

meshFlag = true;

N = 50;


%接收数据端的参数设置
portReceive_Local=port2receive; %接收数据端的端口号，本地的
ipTransmit_Remote='192.168.0.57'; %发送数据端的ip和端口号，远端的/旧盒子
portTransmit_Remote = port2receive;
udpReceive=udp(ipTransmit_Remote,portTransmit_Remote,'LocalPort',portReceive_Local);

% udpReceive.BytesAvailableFcnMode='bytfe';
% udpReceive.BytesAvailableFcnCount = 4; 
% udpReceive.BytesAvailableFcn = @updateUDP; 


% if ~showFlag
    udpReceive.DatagramReceivedFcn=@updateUDP;
% end
udpReceive.DatagramTerminateMode = 'on';

set(udpReceive,'InputBufferSize',4096*32);

% udpReceive.DatagramReceivedFcn = @instrcallback;%显示udp参数，远端ip，接收时间。
try
    fopen(udpReceive);
catch ErrorInfo 
    mydialog([ErrorInfo.message, '   端口被占用']);
end
u = udpReceive;
