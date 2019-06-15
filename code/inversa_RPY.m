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