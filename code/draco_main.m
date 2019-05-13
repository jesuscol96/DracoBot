%This files describes Draco Bot Forward Kinetics

clear; close all;

%Running other files dependecies 
draco_definitions;



%Options for user to choose
con=true;
while (con)
    x=input(['Bienvenidos a DracoBot, ¿Qué desea hacer?:\n'...
            '1 = Cinemática Directa\n'...
            '2 = Cinemática Inversa R+T\n'...
            '3 = Cinemática Inversa T\n'...
            'Otro = Finalizar\n'...
             '>']);
    switch (x)
        case (1)
            q=input('Ingrese el vector de variables articulares en grados (Ejm: [0 0 0 0 0 30]):');
            disp('\nMatriz de transformación:');
            fkine=draco.fkine(q.*(pi/180))            
            draco.plot(q.*(pi/180));
            title(['Manipulador orientado con las variables articulares q=[' num2str(q) '] (grados)']);
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
        case (3)
            fprintf('Cinemática Inversa T:')
            T=draco.fkine(qz)
            t0 = inputdlg({'Ingrese coordenadas del punto deseado'},...
                  'Cinemática Inversa', [1 50]); 
            y = str2num(t0{1})
            T.t=y'
            qi = draco.ikine(T)
            draco.teach(qi)
        otherwise        
            con=false;
    end
    if(con ~= false)    
        con=input('Continuar? (Si = 1, no = 0):');   
    end
end


