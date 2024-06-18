function loc=ts_gaps_localfill(tmc,msl,ref,txt)
% function loc=ts_gaps_localfill(tmc,msl,ref,txt)
%
% TS_GAPS_LOCALFILL Relleno local de GAPS
%       Planeada para relleno de GAPS del Nivel Medio del Mar (SL) con
%       altimetr�a en el per�odo com�n. 
%       Es una alternativa al relleno por interpolaci�n lineal, cuando la
%       correlación no arroja resultados tan buenos.
%
% Variables de entrada:
%
%    tmc = tiempo com�n
%    msl = data del Nivel Medio del Mar (estaci�n)
%    ref = data que servir� para el relleno de <msl>
%          OJO: esta NO deber� tener GAPS
%    txt = texto para ID de las figuras impresas
%
% Variables de salida:
%
%    loc = msl rellenada

% 29/apr/2015, jcedeno@udec.cl

res=ts_gaps_res([tmc(:,1),msl]);
% filtrando solo los segmentos con NaN,
% eliminando la primera columna (id)
ix=find(res(:,1)==0);
res=res(ix,:); res=res(:,2:end);

loc=msl;
for i=1:3
    ixa=[res(i,1)-30,res(i,2)+30];
    % promedio local [muh], SL.
    ty_mean=nanmean(msl(ixa(1):ixa(2)));
    % time on segment
    ty_tmc=tmc(ixa(1):ixa(2));
    % data uh-observed
    ty_suh=msl(ixa(1):ixa(2));
    % data duacs
    ty_sdc=detrend(ref(ixa(1):ixa(2)))+ty_mean;
    % data segment
    ty_fil=msl(ixa(1):ixa(2));
    ix2=find(isnan(ty_fil)==1);
    ty_fil(ix2)=ty_sdc(ix2);
    loc(res(i,1):res(i,2))=ty_sdc(ix2);
    % plot
    subplot(211), 
    plot(ty_tmc,ty_suh,'b'), hold on, plot(ty_tmc,ty_suh,'b.'),
    plot(ty_tmc,ty_sdc,'r'), plot(ty_tmc,ty_sdc,'r.'), datetick('x','mmmyy'),
    subplot(212),
    plot(ty_tmc,ty_fil,'b'), hold on, plot(ty_tmc,ty_fil,'b.'),
    plot(ty_tmc(ix2),ty_fil(ix2),'r.'), datetick('x','mmmyy'),
    % print
    print('-djpeg','-r300',['locfill','_',txt,'_g',num2str(i,'%02.0f')]),
    clf
end
clear ty* ixt ix ixa ixt ix2 i ans

