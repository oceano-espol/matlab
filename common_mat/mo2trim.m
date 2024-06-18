function [inv,pri,ver,oto]=mo2trim(data)
% function [inv,pri,ver,oto]=mo2trim(data)
%
% PRUEBA!!!
%
% Variables de entrada:
%
%    data= 1. col., tiempo, años+dec.año
%          2. col., año
%          3. col., mes
%          4. col., data

data_lbl={'inv','pri','ver','oto'};
estc_mrk=[[6,7,8];...
    [9,10,11];...
    [12,1,2];...
    [3,4,5]];

time_mo = data(:,1:3);
    var = data(:,4);

for i=1:4,
    if i==3,
        % verano, meses [12,1,2]
        ix=find(time_mo(:,3)==estc_mrk(i,1) | time_mo(:,3)==estc_mrk(i,2) | time_mo(:,3)==estc_mrk(i,3));
        ty=var(ix,:); N=length(ty); yrs=N/3;
        % -----------------------------------------------------------------
        % en el año 1, se elimina la primera fila (que equivale al mes 12).
        % el el año N, se eliminan las dos últimas filas (que equivalen a 
        % los meses 1 y 2 del año N+1),
        ty2=ty(3:end-1);
        % ty_mo=time_mo(ix,3); ty2_mo=ty_mo(3:end-1);
        % [ty2_mo,ty2], pause,
        % end of edition---------------------------------------------------
        tyR=reshape(ty2,3,yrs-1); tyS=meanmiss(tyR);
        eval([data_lbl{i},'=tyS;'])
        ix=[]; ty=[]; ty2=[]; tyR=[]; tyS=[];
    else
        ix=find(time_mo(:,3)==estc_mrk(i,1) | time_mo(:,3)==estc_mrk(i,2) | time_mo(:,3)==estc_mrk(i,3));
        ty=var(ix,:); N=length(ty); yrs=N/3;
        ty2=ty(4:end); 
        % ty_mo=time_mo(ix,3); ty2_mo=ty_mo(4:end);
        % [ty2_mo,ty2], pause,
        tyR=reshape(ty2,3,yrs-1); tyS=meanmiss(tyR);
        eval([data_lbl{i},'=tyS;'])
        ix=[]; ty=[]; ty2=[]; tyR=[]; tyS=[];
    end
end

inv=inv'; pri=pri'; ver=ver'; oto=oto';


    
    