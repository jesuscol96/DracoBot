%Este archivo genera trayectorias


prompt ={'Ingrese coordenadas del punto Inicial. x->[-0.9,0.9] ; y->[-0.9,0.9]; z->[-0.6,0.9]', 'Angulo de Roll inicial (grados)', 'Angulo de Pitch inicial (grados)', 'Angulo de Yaw inicial (grados)' 'Ingrese coordenadas del punto Final.x->[-0.9,0.9] ; y->[-0.9,0.9]; z->[-0.6,0.9]','Angulo de Roll final (grados)', 'Angulo de Pitch final (grados)', 'Angulo de Yaw final (grados)', 'Tiempo Maximo', 'Tiempo de Muestreo'};
dlgtitle ='Generador de Trayectorias:';
dims=[1 50];
definput = {'0.1 0.1 0.1','0','0','0','0.5 0.5 0.5','90','90','90','5','0.1'}; 
u = inputdlg(prompt,dlgtitle,dims,definput);
y = u(1);
y = str2num(y{1});
xi=y;
y = u(2);
y = str2num(y{1});
qri=y;
y = u(3);
y = str2num(y{1});
qpi=y;
y = u(4);
y = str2num(y{1});
qyi=y;
y = u(5);
y = str2num(y{1});
xf = y;
y = u(6);
y = str2num(y{1});
qrf=y;
y = u(7);
y = str2num(y{1});
qpf=y;
y = u(8);
y = str2num(y{1});
qyf=y;
y = u(9);
y = str2num(y{1});
tmax = y;
y = u(10);
y = str2num(y{1});
tsam = y;
t = [0:tsam:tmax]';
Ti = SE3(xi) * SE3.Rx(qri)*SE3.Ry(qpi)*SE3.Rz(qyi);
Tf = SE3(xf) * SE3.Rx(qrf)*SE3.Ry(qpf)*SE3.Rz(qyf);
qi = draco.ikine(Ti);
qf = draco.ikine(Tf);
[q qd qdd] = mtraj(@tpoly,qi, qf, t);

disp('Trayectoria generada exitosamente, use la opcion 5 del menu para verificar que no sea singular antes de graficarla.')

traj_creada=1;

if exist('n_sing') 
	clear n_sing;
end
		



