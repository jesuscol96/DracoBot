%This files analyses kinematic velocity of draco bot



disp('Velocidad cinematica.');

x=input(['Seleccione una opcion de analisis.\n'...
            '1 = Analizar una posicion\n'...
            '2 = Analizar una trayectoria (ir a la opcion 4 del menu anterior antes de usar esta funcionalidad)\n'...            
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
		m=[draco.maniplty(q,'trans') draco.maniplty(q,'rot')];
		disp('Promedio de la manipulabilidad traslacional y rotacional');
		mean(m)
		[m_row m_col]=find(m==0);
		if length(m_row)==0 & length(m_col)==0
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

		else
			disp('Se detectaron los siguientes puntos singulares:');
			disp('Vector q y manipulabilidad traslacional y rotacional');
			[q(m_row,:) m(m_row,:)]
			disp('Prueba otra trayectoria que no incluya esos puntos e intente de nuevo.')
		end
end
