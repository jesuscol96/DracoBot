fprintf('Generador de Trayectorias:')
prompt ={'Ingrese coordenadas del punto Inicial', 'Ingrese coordenadas del punto Final', 'Velocidad'};
dlgtitle ='Generador de Trayectorias:';
dims=[1 50];
definput = {'0 0 0','0.5 0.5 0.5','0.1'}; 
u = inputdlg(prompt,dlgtitle,dims,definput)
y = u(1);
y = str2num(y{1})
xi=y
y = u(2);
y = str2num(y{1})
xf = y
y = u(3);
y = str2num(y{1})
v = y
t = [0:v:5]';
Ti = SE3(xi)
Tf = SE3(xf)
qi = draco.ikine(Ti);
qf = draco.ikine(Tf);
[q,qd,qdd] = jtraj(qi, qf, t);
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