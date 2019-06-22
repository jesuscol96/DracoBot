%Este archivo describe la tarea "Movimiento de productos"

tmax=2;
tsam=0.2;
t = [0:tsam:tmax]';
xi=[0.5 0.5 -0.2];
xm=[0.5 0 0.5];
xf=[0.5 -0.5 -0.2];

for i= 1:5
    if mod(i,2)
        HM(:,:,i) = [xi; xf];
    else
        HM(:,:,i) = [xf; xi];
    end
end

Tm = SE3(xm);
qm = draco.ikine(Tm);
for i= 1:5
    Ti = SE3(HM(1,:,i));
    Tf = SE3(HM(2,:,i));
    qi = draco.ikine(Ti);
    qf = draco.ikine(Tf);
    
    [qt qdt qddt] = mtraj(@tpoly,qi, qm, t);
 
    if i==1
        q=qt;
        qd=qdt;
        qdd=qddt;
    else
        q=cat(1,q,qt);
        qd=cat(1,qd,qdt);
        qdd=cat(1,qdd,qddt);
    end
    
    [qt qdt qddt] = mtraj(@tpoly,qm, qf, t);
     q=cat(1,q,qt);
    qd=cat(1,qd,qdt);
    qdd=cat(1,qdd,qddt);
end

%Final time vector
n=length(q);
t=[0:tsam:(n-1)*tsam]';
traj_creada=1;
disp('La trayectoria de esta tarea ha sido cargada, use las opciones del menu para graficar diversos valores.');

if exist('n_sing') 
    clear n_sing;
end

