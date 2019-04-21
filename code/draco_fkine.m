%This files describes Draco Bot Forward Kinetics

clear; close all;

%Lengths of the arm
L1=1;
L2=1;
L3=1;

%Some useful positions
qz = [0 0 0 0 0 0];

%Links definitions
L(1)=Link([0 L1 0 pi/2],'R', 0);
L(2)=Link([0 0 L2   0],'R', 0);
L(3)=Link([0 0 0 pi/2],'R', 0);
L(4)=Link([0 -L3 0 -pi/2],'R', 0);
L(5)=Link([0 0 0 pi/2],'R', 0);
L(6)=Link([0 0 0 -pi/2],'R', 0);

%SerialLink Object
draco=SerialLink(L,'name','Draco');
