%Graficas de Trayectoria
t=tgraf;
figure;
subplot(2,1,1);
qplot(tgraf, q)
T = draco.fkine(q);
p = T.transl;
title('Posicion de las articulaciones');
subplot(2,1,2);
plot(tgraf, p(:,1),'b-',tgraf, p(:,2),'r-',tgraf, p(:,3),'g-')
legend('x','y','z')
xlabel('Tiempo (s)'), ylabel('Posicion (m)')
title('Posicion del extremo del manipulador');
% subplot(2,2,3);
% plot(p(:,1), p(:,2))
% xlabel('x(m)'), ylabel('y(m)')
% subplot(2,2,4);
% plot(tgraf, T.torpy('xyz'))
% xlabel('Tiempo (s)'), ylabel('Angulos de RPY(rad)')

%Graficas de Velocidad Cinematica
m=[draco.maniplty(q,'trans') draco.maniplty(q,'rot')];
disp('Promedio de la manipulabilidad traslacional y rotacional');
mean(m)
[m_row m_col]=find(m==0);

n_sing=1;
disp('No hay singularidades. Graficando velocidades...');
figure;
qplot(t,qd);
title('Velocidad angular de las articulaciones');
xlabel('Tiempo (s)');
ylabel('Velocidad angular (rad/s)');

vel_extremo=[];
for k=1:size(qd,1);
    vel_extremo=[vel_extremo; qd(k,:)*inv(draco.jacob0(q(k,:)))'];
end
figure;
subplot(2,1,1)
plot(t,vel_extremo(:,1));
hold on;
plot(t,vel_extremo(:,2));
hold on;
plot(t,vel_extremo(:,3));
title('Velocidad lineal.');
xlabel('Tiempo (s)');
ylabel('Rapidez (m/s)');
legend('P_x','P_y','P_z');
subplot(2,1,2)
plot(t,vel_extremo(:,4));
hold on;
plot(t,vel_extremo(:,5));
hold on;
plot(t,vel_extremo(:,6));
title('Velocidad angular.');
xlabel('Tiempo (s)');
ylabel('Rapidez angular (rad/s)');
legend('W_a','W_b','W_g');

%Graficas de Dinamica

x=1;
draco.payload(x,[0 0.1 0]);
Q=draco.rne(q,qd,qdd);
figure;
subplot(2,1,1)
plot(t,Q(:,1));
hold on;
plot(t,Q(:,2));
hold on;
plot(t,Q(:,3));
title('Torque en las primeras tres articulaciones.');
xlabel('Tiempo (s)');
ylabel('Torque (N*m)');
legend('t_1','t_2','t_3');
subplot(2,1,2)
plot(t,Q(:,4));
hold on;
plot(t,Q(:,5));
hold on;
plot(t,Q(:,6));
title('Torque en las ultimas tres articulaciones.');
xlabel('Tiempo (s)');
ylabel('Torque (N*m)');
legend('t_4','t_5','t_6');


