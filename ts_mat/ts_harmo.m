function [Coef_eh,Eta_av_eh,Eta_s2_eh]=ts_harmo(data,T,time)
% function [Coef_eh,Eta_av_eh,Eta_s2_eh]=ts_harmo(data,T,time)
%
% TS_HARMO_EH Analisis armonico (mejorado)
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
%     Coef = Coeficientes calculados
%              1  2  3   4
%            [Ai,Bi,Ci,Phi] 
%            ---> Ai, Bi y Ci, en la misma unidad que los datos de NMM
%            ---> Phi, Fase en radianes
%   Eta_av = NMM armonico reconstruido (+ Eta promedio) 
%   Eta_s2 = NMM armonico reconstruido (- Eta promedio)

% Created on:   23/oct/2013, jcedeno@udec.cl 
%                  Segun las indicaciones de la clase de armonicos
%                  impartida por el prof. Oscar Pizarro, como parte de la
%                  tutoria de tesis. Mgs. Oceanografia, U. de Concepcion.
% Edited:       12/nov/2012, jcedeno@udec.cl
%               18/nov/2012, jcedeno@udec.cl (variantes CS/EH)

% Designacion EH ---> Metodo mejorado. El loop para resolver N armonicos
%                     se encuentra fuera del bucle que soluciona las 
%                     matrices a y b, para aumentar la precision.


% especificando <t> para la ecuacion, removiendo la media en Eta, y 
% pasando T (periodo) a og (omega, frecuencia angular)
%
% t --> tiempo,     eta_s ---> eta estrella (eta menos eta promedio)
% og --> omega,     N --> No. de periodos armonicos ingresados
% ...
t=data(:,1);            eta_s=data(:,2)-nanmean(data(:,2));
T2=T;                   og2=(2.*pi.*(1./T));    
N2=length(T(:));        N=1;

% Para simplificar el paso de ejecutar afuera el bucle que resuelve N
% armonicos, se conserva N como n�mero de armonicos (pero siempre siendo 
% de dimensiones == 1x1 ), y N2 como el contador real de N armonicos.


for k=1:N2,
    
    og=og2(k); T=T2(k);
    
    % ---------------------------------------------------------------------
    a=zeros(2*N); b=zeros(2*N,1);
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
    X=a\b;
    % ---------------------------------------------------------------------
    
    X_Rs=reshape(X,length(T),length(X)/length(T));
    
    % whos X X_Rs a b, pause,
    
    Ai=X_Rs(:,1);                   Bi=X_Rs(:,2);
    Ci=(Ai.^2+Bi.^2).^(1/2);        Phi=atan(Ai./Bi);
    Coef=[Ai,Bi,Ci,Phi];
    
    Eta_s2=zeros(length(time),N);       % Eta_s1=zeros(length(time),N);
    
    for h=1:N
        for i=1:length(time),
            % Eta_s1(i)=sum(Ci.*cos(og.*time(i)+Phi));
            Eta_s2(i,h)=sum(Ai(h).*sin(og.*time(i))+Bi(h).*cos(og.*time(i)));
        end
    end
    
    Eta_av=Eta_s2+nanmean(data(:,2));
    % -------------------------------------------------------------------------
    
    Coef_eh(k,:)=Coef;
    Eta_av_eh(:,k)=Eta_av;
    Eta_s2_eh(:,k)=Eta_s2;
    
    aa=[]; bb=[]; ab_ba=[];
    a=[]; b=[]; X=[]; X_Rs=[]; Ai=[]; Bi=[]; Ci=[]; Phi=[];
    Coef=[]; Eta_s2=[]; Eta_av=[];
    
end




