%Este archivo permite graficar una trayectoria ya generada.
if exist('traj_creada')
	if exist('n_sing') 
		if n_sing==1
			figure;
			title('Trayectoria del manipulador')
			draco.teach(q)
			figure;
			subplot(2,2,1);
			qplot(t, q)
			T = draco.fkine(q);
			p = T.transl;
			subplot(2,2,2);
			plot(t, p(:,1),'b-',t, p(:,2),'r-',t, p(:,3),'g-')
			legend('x','y','z')
			xlabel('Tiempo (s)'), ylabel('Posicion (m)')
			subplot(2,2,3);
			plot(p(:,1), p(:,2))
			xlabel('x(m)'), ylabel('y(m)')
			subplot(2,2,4);
			plot(t, T.torpy('deg'))
			xlabel('Tiempo (s)'), ylabel('Angulos de RPY(rad)')
		else
			disp('La trayectoria planteada contiene puntos singulares y no puede ser usada.');
		end
	else
		disp('Debe verificar que la trayectoria sea no singular antes de graficarla.');
	end
else
	disp('Debe generar una trayectoria antes de usar esta opcion.');
end