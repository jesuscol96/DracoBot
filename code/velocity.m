%This files analyses kinematic velocity of draco bot



disp('Velocidad cinematica.');

x=input(['Seleccione una opcion de analisis.\n'...
            '1 = Analizar una posicion\n'...
            '2 = Analizar una trayectoria\n'...            
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


end
