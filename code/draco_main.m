%This files describes Draco Bot Forward Kinetics

clear; close all;

%Running other files dependecies 
draco_definitions;



%Options for user to choose
x=0;
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


