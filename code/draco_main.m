%This files describes Draco Bot Forward Kinetics

clear; close all;

%Running other files dependecies 
draco_definitions;



%Options for user to choose
con=true;
while (con)
    x=input(['Bienvenidos a DracoBot, øQuÈ desea hacer?:\n'...
            '1 = Cinem·tica Directa\n'...
            '2 = Cinem·tica Inversa R+T\n'...
            '3 = Cinem·tica Inversa RPY\n'...
            'Otro = Finalizar\n'...
             '>']);
    switch (x)
        case (1)
            q=input('Ingrese el vector de variables articulares en grados (Ejm: [0 0 0 0 0 30]):');
            disp('\nMatriz de transformaci√≥n:');
            fkine=draco.fkine(q.*(pi/180))            
            draco.plot(q.*(pi/180));
            title(['Manipulador orientado con las variables articulares q=[' num2str(q) '] (grados)']);
        case (2)
            fprintf('Cinem√°tica Inversa T:')
            T=draco.fkine(qz)
            K =[1 0 0 0;0 0 -1 0; 0 1 0 0; 0 0 0 1]
            prompt ={'Ingrese coordenadas traslacionales del punto deseado\n ', 'Orientacion eje x', 'Orientacion eje y', 'Orientacion eje z' };
            dlgtitle ='Cinem√°tica Inversa';
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
            fprintf('Cinem·tica Inversa RPY:')
            prompt ={'Ingrese coordenadas traslacionales del punto deseado\n ', '[[Angulo de Roll', 'Angulo de Pitch', 'Angulo de Yaw' };
            dlgtitle ='Cinem√°tica Inversa';
            dims=[1 50];
            definput = {'0 0 0','0','0','0'}; 
            u = inputdlg(prompt,dlgtitle,dims,definput)
            y = u(1);
            y = str2num(y{1})
            tf=y
            y = u(2);
            y = str2num(y{1})
            qr = y
            y = u(3);
            y = str2num(y{1})
            qp = y
            y = u(4);
            y = str2num(y{1})
            qy = y
            Tf = SE3(tf) * SE3.Rz(qr)*SE3.Ry(qp)*SE3.Rx(qy);
            qf = draco.ikine(Tf);
            q = jtraj(q0, qf, t);
            q0=qf;
            figure(1);
            draco.teach(q)
            figure(2);
            clf(figure(2),'reset')
            subplot(2,2,1);
            qplot(t, q)
            T = draco.fkine(q);
            p = T.transl
            subplot(2,2,2);
            plot(t, p(:,1),'b-',t, p(:,2),'r-',t, p(:,3),'g-')
            legend('x','y','z')
            xlabel('Time (s)'), ylabel('Position (m)')
            subplot(2,2,3);
            plot(p(1,:), p(2,:))
            xlabel('x(m)'), ylabel('y(m)')
            subplot(2,2,4);
            plot(t, T.torpy('xyz'))
            xlabel('Time (s)'), ylabel('RPY angles(rad)')
        otherwise        
            con=false;
    end
    if(con ~= false)    
        con=input('Continuar? (Si = 1, no = 0):');   
    end
end


