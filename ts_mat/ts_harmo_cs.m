function [Coef,Eta_av,Eta_s2]=ts_harmo_cs(data,T,time)
% function [Coef,Eta_av,Eta_s2]=ts_harmo_cs(data,T,time)
%
% TS_HARMO_CS Analisis armonico
%
% Variables de entrada
% 
%     data = matriz de datos de entrada [M*2]
%            1col., eje de tiempo (juliano o annos+fraccion decimal de a�o)
%            2col., datos del nivel medio del mar
%        T = periodo(s) para el cual <harmo> estimara las amplitudes
%     time = eje de tiempo de referencia para la cual <harmo> calculara
%            la nueva serie <out> en base a los periodos armonicos <T>
%
% Variables de salida
%
%     Coef = Constituyentes armonicos
%            [Ai,Bi,Ci] (en misma unidad de datos NMM)
%      Phi = Fase (en radianes)
%   Eta_av = NMM armonico reconstruido (+ Eta promedio) 
%   Eta_s2 = NMM armonico reconstruido (- Eta promedio)

% Created on:   23/oct/2013, jcedeno@udec.cl 
%                  Segun las indicaciones de la clase de armonicos
%                  impartida por el prof. Oscar Pizarro, como parte de la
%                  tutoria de tesis. Mgs. Oceanografia, U. de Concepcion.
% Edited:       12/nov/2012, jcedeno@udec.cl
%               18/nov/2012, jcedeno@udec.cl (variantes CS/EH)

% Designacion CS ---> Metodo clasico. El loop para resolver N armonicos
%                     esta anidado a los bucles que soluciona las matrices
%                     a y b.


% especificando <t> para la ecuacion, removiendo la media en Eta, y 
% pasando T (periodo) a og (omega, frecuencia angular)
%
% t  --> tiempo,      eta_s --> eta estrella (eta menos eta promedio)
% og --> omega,           N --> No. de periodos armonicos ingresados
% ...
t=data(:,1);            eta_s=data(:,2)-nanmean(data(:,2));
og=(2.*pi.*(1./T));     N=length(T(:));

% preallocating
% ...
a=zeros(2*N); b=zeros(2*N,1);

% el bucle correra de 1, ... N, segun el no. de periodos armonicos
% especificados
% ...
for j=1:N,
    for i=1:N,
        aa=sum(sin(og(j).*t).*sin(og(i).*t));       % grupo [aa]
        ab_ba=sum(sin(og(j).*t).*cos(og(i).*t));    % grupo [ab y ba]
        bb=sum(cos(og(j).*t).*cos(og(i).*t));       % grupo [bb]
        a(j,i)=aa;              a(j,i+N)=ab_ba;    
        a(j+N,i)=ab_ba;         a(j+N,i+N)=bb;
    end
    b(j)=sum(eta_s.*sin(og(j).*t));
    b(j+N)=sum(eta_s.*cos(og(j).*t));
end

% el planteamiento de la ecuacion que resuelve armonicos es aX=b, pero las
% incognitas (amplitudes) estan en la matriz X. asi que, despejando:
% ...
X=a\b;

% con este arreglo, se ha obtenido finalmente los coeficientes Ai y Bi, los 
% cuales se encuentran en la matriz <X> [A1, A2,... N, B1, B2,... N].

% dada la expresion
% 
% Eta_s(t) = Sum[Ci cos(Omg_i t) + Phi]
% 
% tenemos que <Ci> es igual a [Ai^2 + Bi^2]^(1/2), y que <Phi> es igual 
% a atan[Ai/Bi]. Asi, debemos de encontrar estos valores, que son 
% equivalentes a la amplitud del arm�nico especificado por <T> (en el caso
% de Ci); asi como la fase (Phi).

X_Rs=reshape(X,length(T),length(X)/length(T));

% whos X X_Rs a b, pause,

Ai=X_Rs(:,1);                   Bi=X_Rs(:,2);
Ci=(Ai.^2+Bi.^2).^(1/2);        Phi=atan(Ai./Bi);
Coef=[Ai,Bi,Ci,Phi];

% preallocating
% ...
Eta_s2=zeros(length(time),N);       % Eta_s1=zeros(length(time),N);   

for h=1:N
    for i=1:length(time),
        % Eta_s1(i)=sum(Ci.*cos(og.*time(i)+Phi));
        Eta_s2(i,h)=sum(Ai(h).*sin(og.*time(i))+Bi(h).*cos(og.*time(i)));
    end
end

Eta_av=Eta_s2+nanmean(data(:,2));




