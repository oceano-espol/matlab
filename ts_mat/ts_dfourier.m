function [Ci2,f,Ci2_Alt]=ts_dfourier(x,n,Fs)
% function [Ci2,f,Ci2_Alt]=ts_dfourier(data,n,Fs)
%
% TS_DFOURIER Transformada Discreta de Fourier
%             * Antigua <ts_spectrum_v2>
%
% Variables de entrada:
%
%       x = datos (e.g., nivel medio del mar, en cm)
%       n = numero de segmentos a promediar
%      Fs = frecuencia de muestreo (e.g., datos diarios --> Fs = 1)
%

% en la jerga de la rutina <ts_harmo>, calcularemos varios armónicos,
% siendo el más grande el T, que es igual a length(T). el armónico más
% pequeño será 2*Fs --> es decir, dos veces la frecuencia de muestreo.

N=length(x);        % N --> longitud de x (datos)

% [1] eleccion de subdivision de series ...................................
%     p2, serie referencial de potencias de 2
%     M,  longitud de los segmentos en los que la serie fue sub-dividida
%         este valor es potencia de 2
% ...
p2 = [ones(1,25).*2;...
      1:1:25;...
      (ones(1,25).*2).^(1:1:25)];
ix = find(p2(3,:)<N/n);
M  = p2(3,ix(length(ix)));

disp(['La serie será subdivida en ',num2str(n),' segmentos de ',num2str(p2(1,ix(length(ix)))),...
    '(exp)',num2str(p2(2,ix(length(ix)))),' = ',num2str(M),' puntos.']),
disp('.'), pause(.5), disp('..'), pause(.5), disp('...'), pause(1),

x_org=x;    x=x(1:M*n);
ix=[]; N=[];

ix_1=[1:M:M*(n+1)];
ix=[ix_1(1:length(ix_1)-1);...
    [ix_1(2:length(ix_1))-1]]', % pause,
for i=1:length(ix),
    eta_s(:,i)=x(ix(i,1):ix(i,2));
end

% [2] definicion de T (periodo) ...........................................
%     para cada T, se correran las ecuaciones de Fourier para el calculo 
%     de los coeficientes Ai y Bi.
%     T es equivalente tambien a la variable <tiempo> en las ecuaciones de
%     Fourier.
% ...
T=[2*Fs:1:length(eta_s(:,1))*Fs]';
N=length(T),        % N --> longitud de T (período)

[T,1./T], pause,

Ai=ones(N,length(ix)).*NaN;
Bi=ones(N,length(ix)).*NaN;

% [3] ecuaciones de Fourier ...............................................
%     bucle anidado, para cada segmento, para cada valor de T.
% ...
wt=waitbar(0,'Espere...');
for h=1:length(ix),
    for i=1:N,
        %  el cociente <1/T(i)> corresponde a la frecuencia,
        %  definida desde [1/(2*Fs)] hasta [1/N*Fs].
        %  [1/(2*Fs)] es la frecuencia Nyquist.
        og=(2*pi*(1/T(i)));
        Ai(i,h)=(2/N)*nansum(eta_s(:,h).*cos(og.*[0;T]));
        Bi(i,h)=(2/N)*nansum(eta_s(:,h).*sin(og.*[0;T]));
    end
    waitbar(h/length(ix),wt),
end
close(wt),

Ci2=(Ai.^2+Bi.^2);  f=1./T;

% .........................................................................

n=[];
n=length(Ci2);

f2=[(1:n-1)/n*Fs/2]';
power=Ci2(2:n,:);
Ci2_Alt=[sortrows(f2,-1),power];


