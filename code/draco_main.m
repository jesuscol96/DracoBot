%This files describes Draco Bot Forward Kinetics

clear; close all;

%Running other files dependecies 
draco_definitions;


%Options for user to choose
con=true;
while (con)
    x=input(['Bienvenidos a DracoBot, øQuÈ desea hacer?:\n'...
            '1 = Cinem·tica Directa\n'...
            '2 = Cinem·tica Inversa RPY\n'...
            '3 = Generar trayectorias.\n'...
            '4 = Graficar trayectorias.\n'...
            '5 = Velocidad cinem·tica.\n' ...
            '6 = An·lisis din·mico\n'...
            '7 = Cargar una tarea.\n'...
            'Otro = Finalizar\n'...
             '>']);
    switch (x)
        case(1)
            q=input('Ingrese el vector de variables articulares en grados (Ejm: [0 0 0 0 0 30]):');
            disp('\nMatriz de transformaci√≥n:');
            fkine=draco.fkine(q.*(pi/180))            
            draco.plot(q.*(pi/180));
            title(['Manipulador orientado con las variables articulares q=[' num2str(q) '] (grados)']);
        case(2)
            inversa_RPY;        
        case(3)
            trayectorias_join;
        case(4)
            plot_traj;
        case(5)
            velocity;
        case(6)
            dynamic;
        case(7)
            tareas;        

        otherwise        
            con=false;
    end
    if(con ~= false)    
        con=input('Continuar? (Si = 1, no = 0):');   
    end
end


