%This files describes the dynamic behavior of DracoBot

disp('Analisis dinamico.');

x=input(['Seleccione una opcion de analisis.\n'...
            '1 = Analizar una configuracion (posicion, velocidad y aceleracion dadas)\n'...
            '2 = Analizar una trayectoria (generada con opcion 3 y verificada no singular con opcion 4.2)\n'...            
             '>']);
%get info
switch (x)
	case(1)
		x=input('¿Sostener un objeto en el extremo del manipulador?(1/0)');
		if x
			x=input('Masa del objeto (kg):');
			draco.payload(x,[0 0.1 0]);
		end

		disp('Indicar los siguientes vectores de variables articulares:');
		q=input('Posicion (grados):');		
		qd=input('Velocidad (grados/s):');
		qdd=input('Aceleracion (grados/s2):');
		q=q*(pi/180);
		qd=qd*(pi/180);
		qdd=qdd*(pi/180);	

		%Inertia matrix		
		fprintf('Matriz de inercia de las articulaciones (N*m):\n');
		M_inertia=draco.inertia(q)

		%Coriolis matrix		
		fprintf('Matriz de coriolis de las articulaciones (N*m):\n');
		C_coriolis=draco.coriolis(q,qd)

		%Vector of torques	
		Q=draco.rne(q,qd,qdd);
		fprintf(['Vector de torques articulares necesarios (N*m):\n' num2str(Q) '\n']);

		%Vector of gravload
		gv=draco.gravload(q);
		fprintf(['Vector de torques articulares necesarios solo para vencer la gravedad, o velocidad y aceleracion nula (N*m):\n' num2str(gv) '\n']);

		%Vector de friccion
		fr=draco.friction(qd);
		fprintf(['Vector de torques de friccion de las articulaciones para la velocidad dada (N*m):\n' num2str(fr) '\n']);
		
	case(2)
		if exist('n_sing') 
				if n_sing==1
					x=input('¿Sostener un objeto en el extremo del manipulador?(1/0)');
				if x
					x=input('Masa del objeto (kg):');
					draco.payload(x,[0 0.1 0]);
				end
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
			else
				disp('La trayectoria planteada contiene puntos singulares y no puede ser usada.');
			end
		else
			disp('Debe generar una trayectoria primero (use la opcion 3) y verificar que sea no singular (opcion 4.2)');
		end

	otherwise
		disp('Opcion invalida.')
end