%This files describes the dynamic behavior of DracoBot

disp('Analisis dinamico.');

x=input(['Seleccione una opcion de analisis.\n'...
            '1 = Analizar una configuracion (posicion, velocidad y aceleracion dadas)\n'...
            '2 = Analizar una trayectoria (ir a la opcion 4 del menu anterior antes de usar esta funcionalidad)\n'...            
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




	otherwise
		disp('Opcion invalida.')


end