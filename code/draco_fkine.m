%This files describes Draco Bot Forward Kinetics

clear; close all;
x=0;
%Lengths of the arm
L1=1;
L2=1;
L3=1;

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



while (1)
    x=input('Bienvenidos a DracoBot,¿ Qué desea hacer?:\n 1 = Cinemática Directa\n 2 = Cinemática Inversa\n')
    switch (x)
        case (1)
            fprintf('Cinemática Directa:')
            draco.teach(qz)
            x=0;
        case (2)
            fprintf('Cinemática Inversa\n:')
            T=draco.fkine(qz)
            t0 = inputdlg({'Ingrese coordenadas del punto deseado'},...
                  'Cinemática Inversa', [1 50]); 
            y = str2num(t0{1})
            T.t=y'
            qi = draco.ikine(T)
            draco.teach(qi)
            x=0;

    end
end
