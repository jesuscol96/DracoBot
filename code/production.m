draco_definitions;
tmax=2;
tsam=0.2;
t = [0:tsam:tmax]';
xi=[0.5 0.5 -0.2];
xm=[0.5 0 0.5];
xf=[0.5 -0.5 -0.2];
draco.teach(q0)

for i= 1:5
    if mod(i,2)
        HM(:,:,i) = [xi; xf];
    else
        HM(:,:,i) = [xf; xi];
    end
end
for i= 1:10
    if i==1
        tgraf=t;
    else 
        tgraf=cat(1,tgraf,t+tmax*i);
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
    draco.teach(qt)
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
    draco.teach(qt)
    q=cat(1,q,qt);
    qd=cat(1,qd,qdt);
    qdd=cat(1,qdd,qddt);
end

trayecplot;
