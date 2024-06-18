function Pav=ts_csensambled(x,y,M)
% function Pav=ts_csensambled(x,y,M)
%
% TS_CSENSAMBLED Cross-spectra Ensembled
% 
% Variables de entrada
%
% x o y = data
%         filas: datos por años
%       column.: datos a lo largo del tiempo
%     m = longitud del segmento (debe ser potencia de dos)

L=length(x(:,1));   % equivalente al número de años 

% *running the spectrum
for i=1:L,
    [ty,p2]=orpa_cohe(x(i,:)',y(i,:)',M,0);
    if i==1,
        Fs=ty(:,1);
    end
    % reteniendo los espectros estandarizados
    % (la salida directa de cohe)
    Pxx(:,i)=ty(:,2);
    Pyy(:,i)=ty(:,3);
    % reteniendo los espectros crudos
    % (linea 130 de orpa_cohe)
    P2xx(:,i)=p2(:,1);
    P2yy(:,i)=p2(:,2);
    P2xy(:,i)=p2(:,3);
end
% cohe. [Cxy]
Cxy=(abs(mean(P2xy,2)).^2)./...
    (mean(P2xx,2).*mean(P2yy,2));
% phase [Fxy]
Fxy=angle(mean(P2xy,2)).*(180/pi);
% ensembling on [Pav]
Pav=[Fs,...
    mean(Pxx,2),mean(Pyy,2),...
    Cxy,Fxy];

