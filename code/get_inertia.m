%Function to calculate inertia tensor
%a=length (x)
%b=width (y)
%c=thickness (z)

function [Ixx Iyy Izz]=get_inertia(m,x,y,z)
	Ixx=(1/12)*m*(y^2+z^2);
	Iyy=(1/12)*m*(x^2+z^2);
	Izz=(1/12)*m*(y^2+x^2);