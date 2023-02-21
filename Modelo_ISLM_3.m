%{
%Señalamos las variables
syms Ir PLy PLr EMy Kr KE Xy XE EME EMG dG0 dE dY_1 dEm dGm dD dr_1 dEk theta

% Creamos el sistema de matrices
A = [-theta Ir 0; -PLy -PLr 1; -EMy -Kr 0];
B = [-1 -Xy -XE EME EMG 0 0 0; 0 0 0 0 0 -1 0 0; 0 Xy XE -EME -EMG 0 -Kr -KE];
y = [dG0; dY_1; dE; dEm; dGm; dD; dr_1; dEk];

%Resolvemos para A
detA = det(A);
Ainv = inv(A)
J = Ainv*B
x = J*y;
dy=x(1)
dr=x(2)
dR=x(3)

%}
%% Modelo dinámico
function islm=Modelo_ISLM_3(t,variables);
% Descripción del proceso
y=variables(1);
r=variables(2);
R=variables(3)

% Parámetros
Ir = 8
PLy = 7
PLr = 9
EMy = 12
Kr = 4
KE = 5
Xy = 9
XE = 11 
EME = 13
EMG = 9
dG0 = 10
dE = 5
dY_1 = 20
dEm =15
dGm = 10
dD = 10
dr_1 = 10
dEk = 7
theta = 0.2

% Ecuaciones diferenciales
dy = dEm*((EME*Ir)/(Kr*theta + EMy*Ir) - (EME*Kr)/(Kr*theta + EMy*Ir)) + dGm*((EMG*Ir)/(Kr*theta + EMy*Ir) - (EMG*Kr)/(Kr*theta + EMy*Ir)) - dE*((Ir*XE)/(Kr*theta + EMy*Ir) - (Kr*XE)/(Kr*theta + EMy*Ir)) - dY_1*((Ir*Xy)/(Kr*theta + EMy*Ir) - (Kr*Xy)/(Kr*theta + EMy*Ir)) + (Kr*dG0)/(Kr*theta + EMy*Ir) + (Ir*KE*dEk)/(Kr*theta + EMy*Ir) + (Ir*Kr*dr_1)/(Kr*theta + EMy*Ir);
dr = dEm*((EME*EMy)/(Kr*theta + EMy*Ir) + (EME*theta)/(Kr*theta + EMy*Ir)) + dGm*((EMG*EMy)/(Kr*theta + EMy*Ir) + (EMG*theta)/(Kr*theta + EMy*Ir)) - dE*((EMy*XE)/(Kr*theta + EMy*Ir) + (XE*theta)/(Kr*theta + EMy*Ir)) - dY_1*((EMy*Xy)/(Kr*theta + EMy*Ir) + (Xy*theta)/(Kr*theta + EMy*Ir)) - (EMy*dG0)/(Kr*theta + EMy*Ir) + (KE*dEk*theta)/(Kr*theta + EMy*Ir) + (Kr*dr_1*theta)/(Kr*theta + EMy*Ir);
dR = dEm*((EME*(EMy*PLr - Kr*PLy))/(Kr*theta + EMy*Ir) + (EME*(PLr*theta + Ir*PLy))/(Kr*theta + EMy*Ir)) - dD + dGm*((EMG*(EMy*PLr - Kr*PLy))/(Kr*theta + EMy*Ir) + (EMG*(PLr*theta + Ir*PLy))/(Kr*theta + EMy*Ir)) - dE*((XE*(PLr*theta + Ir*PLy))/(Kr*theta + EMy*Ir) + (XE*(EMy*PLr - Kr*PLy))/(Kr*theta + EMy*Ir)) - dY_1*((Xy*(PLr*theta + Ir*PLy))/(Kr*theta + EMy*Ir) + (Xy*(EMy*PLr - Kr*PLy))/(Kr*theta + EMy*Ir)) - (dG0*(EMy*PLr - Kr*PLy))/(Kr*theta + EMy*Ir) + (KE*dEk*(PLr*theta + Ir*PLy))/(Kr*theta + EMy*Ir) + (Kr*dr_1*(PLr*theta + Ir*PLy))/(Kr*theta + EMy*Ir);
 
% Agrupar el vector de datos
islm = [dy dr dR]';