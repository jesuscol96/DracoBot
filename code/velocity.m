%This files analyses kinematic velocity of draco bot



disp('Velocidad cinematica.');

x=input(['Seleccione una opcion de analisis.\n'...
            '1 = Analizar una posicion\n'...
            '2 = Determinar si una trayectoria es singular.\n'...  
            '3 = Graficar velocidades.\n'...            
             '>']);
%get info
switch (x)
	case(1) %Analiza una posición en especifica del manipulador
		q=input('Ingrese la posicion de las articulaciones:');
		q=q*(pi/180);

		%jacobiano
		disp('Jacobiano para la posicion dada:');
		J=draco.jacob0(q)

		%Manipulabilidad:
		disp('Manipulabidad:');
		draco.maniplty(q)

		figure;
		plot_ellipse(J(1:3,:)*J(1:3,:)')
		title('Posibles velocidades translacionales');
		xlabel('x');
		ylabel('y');
		zlabel('z');

		figure;
		plot_ellipse(J(4:6,:)*J(4:6,:)')
		title('Posibles velocidades rotacionales');
		xlabel('alfa');
		ylabel('beta');
		zlabel('gamma');
	case(2)
		if exist('traj_creada')
			m=[draco.maniplty(q,'trans') draco.maniplty(q,'rot')];
			disp('Promedio de la manipulabilidad traslacional y rotacional');
			mean(m)
			[m_row m_col]=find(m==0);
			if length(m_row)==0 & length(m_col)==0
				n_sing=1;
				disp('No hay singularidades.');
			else
				n_sing=0;
				disp('Se detectaron los siguientes puntos singulares:');
				disp('Vector q y manipulabilidad traslacional y rotacional');
				[q(m_row,:) m(m_row,:)]
				disp('Prueba otra trayectoria que no incluya esos puntos e intente de nuevo.')
			end
		else
			disp('Debe crear una trayectoria antes de usar esta opcion');
		end
	case(3)
		if exist('traj_creada')
			if exist('n_sing')
				if n_sing==1
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
				else
					disp('La trayectoria planteada contiene puntos singulares y no puede ser usada.');
				end
			else
				disp('Debe verificar que la trayectoria sea no singular antes de graficarla.');
			end
		else
			disp('Debe crear una trayectoria antes de usar esta opcion');
		end
	end