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
    x=input('Bienvenidos a DracoBot,¿ Qué desea hacer?:\n 1 = Cinemática Directa\n 2 = Cinemática Inversa R+T\n 3 = Cinemática Inversa T\n')
    switch (x)
        case (1)
            fprintf('Cinemática Directa:')
            draco.teach(qz)
            x=0;
        case (2)
            fprintf('Cinemática Inversa T:')
            T=draco.fkine(qz)
            K =[1 0 0 0;0 0 -1 0; 0 1 0 0; 0 0 0 1]
            prompt ={'Ingrese coordenadas traslacionales del punto deseado\n ', 'Orientacion eje x', 'Orientacion eje y', 'Orientacion eje z' };
            dlgtitle ='Cinemática Inversa';
            dims=[1 50];
            definput = {'0 0 0','1 0 0','0 0 1','0 -1 0'}; 
            u = inputdlg(prompt,dlgtitle,dims,definput)
            y = u(1);
            y = str2num(y{1})
            K(1:3 ,4) = y';
            y = u(2);
            y = str2num(y{1})
            K(1:3 ,1) = y';
            y = u(3);
            y = str2num(y{1})
            K(1:3 ,2) = y';
            y = u(4);
            y = str2num(y{1})
            K(1:3 ,3) = y';
            qi = draco.ikine(K)
            draco.teach(qi)
            x=0;
        case (3)
            fprintf('Cinemática Inversa T:')
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


