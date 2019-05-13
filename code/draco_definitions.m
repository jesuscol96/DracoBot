%This file describes the physical structure of the robot


%Lengths of the arm
L1=0.3;
L2=0.5;
L3=0.5;

%Some useful positions
qz = [0 0 0 0 0 0];
qn = [0 0.7854 3.1416 0 0.7854 0 ];

%Links definitions
L(1)=Link([0 L1 0 pi/2],'R', 0);
L(2)=Link([0 0 L2   0],'R', 0);
L(3)=Link([0 0 0 pi/2],'R', 0);
L(4)=Link([0 -L3 0 -pi/2],'R', 0);
L(5)=Link([0 0 0 pi/2],'R', 0);
L(6)=Link([0 0 0 -pi/2],'R', 0);

%SerialLink Object
draco=SerialLink(L,'name','Draco');