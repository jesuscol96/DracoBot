%Este archivo describe la cinematica inversa de DracoBot

fprintf('Cinemática Inversa RPY:')
prompt ={'Ingrese coordenadas traslacionales del punto deseado. x->[-0.9,0.9] ; y->[-0.9,0.9]; z->[-0.6,0.9]' , 'Angulo de Roll (grados)', 'Angulo de Pitch(grados)', 'Angulo de Yaw(grados)' };
dlgtitle ='Cinematica Inversa';
dims=[1 50];
definput = {'0 0 0','0','0','0'}; 
u = inputdlg(prompt,dlgtitle,dims,definput);
y = u(1);
y = str2num(y{1});
tf=y;
y = u(2);
y = str2num(y{1});
qr = y *(pi/180);
y = u(3);
y = str2num(y{1});
qp = y*(pi/180);
y = u(4);
y = str2num(y{1});
qy = y*(pi/180);
Tf = SE3(tf) * SE3.Rz(qr)*SE3.Ry(qp)*SE3.Rx(qy);

disp('Matriz de transformacion asociada a la posicion seleccionada:');
Tf
disp('Configuracion de las articulaciones necesaria para lograr la posicion elegida:');
qf = draco.ikine(Tf)
figure;
draco.teach(qf)
title('Manipulador en la posicion deseada.')
