fprintf('Generador de Trayectorias:')
prompt ={'Ingrese coordenadas del punto Inicial', 'Angulo de Roll inicial', 'Angulo de Pitch inicial', 'Angulo de Yaw inicial' 'Ingrese coordenadas del punto Final','Angulo de Roll final', 'Angulo de Pitch final', 'Angulo de Yaw final', 'Tiempo Maximo', 'Tiempo de Muestreo'};
dlgtitle ='Generador de Trayectorias:';
dims=[1 50];
definput = {'0 0 0','0','0','0','0.5 0.5 0.5','pi/2','pi/2','pi/2','5','0.1'}; 
u = inputdlg(prompt,dlgtitle,dims,definput)
y = u(1);
y = str2num(y{1})
xi=y
y = u(2);
y = str2num(y{1})
qri=y
y = u(3);
y = str2num(y{1})
qpi=y
y = u(4);
y = str2num(y{1})
qyi=y
y = u(5);
y = str2num(y{1})
xf = y
y = u(6);
y = str2num(y{1})
qrf=y
y = u(7);
y = str2num(y{1})
qpf=y
y = u(8);
y = str2num(y{1})
qyf=y
y = u(9);
y = str2num(y{1})
tmax = y
y = u(10);
y = str2num(y{1})
tsam = y
t = [0:tsam:tmax]';
Ti = SE3(xi) * SE3.Rz(qri)*SE3.Ry(qpi)*SE3.Rx(qyi);
Tf = SE3(xf) * SE3.Rz(qrf)*SE3.Ry(qpf)*SE3.Rx(qyf);
qi = draco.ikine(Ti);
qf = draco.ikine(Tf);
[q qd qdd] = mtraj(@tpoly,qi, qf, t);
figure;
draco.teach(q)
figure;
subplot(2,2,1);
qplot(t, q)
T = draco.fkine(q);
p = T.transl
subplot(2,2,2);
plot(t, p(:,1),'b-',t, p(:,2),'r-',t, p(:,3),'g-')
legend('x','y','z')
xlabel('Tiempo (s)'), ylabel('Posicion (m)')
subplot(2,2,3);
plot(p(1,:), p(2,:))
xlabel('x(m)'), ylabel('y(m)')
subplot(2,2,4);
plot(t, T.torpy('xyz'))
xlabel('Tiempo (s)'), ylabel('Angulos de RPY(rad)')