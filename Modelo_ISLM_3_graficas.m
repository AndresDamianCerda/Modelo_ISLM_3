%% Modelo IS-LM de economía cerrada
% Ismael D. Valverde Ambriz
% ismaelvalverde02@gmail.com

% Condiciones iniciales de las variables
variables0 = [100, 0.10, 5]';

% Rango de tiempo de integración
tspan = [0 12 15];

% Resolver la Ecuación diferencial
[t, variables] = ode45(@Modelo_ISLM_3,tspan,variables0);

% Separando resultados
y = variables(:,1);
r = variables(:,2);
R = variables(:,3);

% Gráficar
figure
plot(t,y)
title('Trayectoria del Producto')
figure
plot(t,r)
title('Trayectoria de la tasa de interés')
figure
plot(t,R)
title('Trayectoria')