function desc=binavg21(tp,sa,prs)
% function desc=binavg21(tp,sa,prs)
%
% BINAVG21 Bin average de datos CTD
%          Ajustado para hacer un promedio de celda de 2 m,
%          junto con un promedio de celda de 1 m para obtener el valor
%          mas cercano a la superficie.
%
% Datos de entrada:
%   tp,  temperatura [°C]
%   sa,  salinidad [ ]
%   prs, presion [db]
%
% 28-JUL-2024, jcedeno@espol.edu.ec

[~,desc_2]=binavg_int([prs,tp,sa],2);
    desc_2=[desc_2(:,1),desc_2(:,3),desc_2(:,4)];

[~,desc_1]=binavg_int([prs,tp,sa],1);
    desc_1=[desc_1(:,1),desc_1(:,3),desc_1(:,4)];

desc = [desc_1(1,:);desc_2];

function [answ57,desc,asce,align]=binavg_int(data,binsize)
%function [answ57,desc,asce,align]=binavg_int(data,binsize)
% BINAVG Promedio de datos segun un binsize de profundidad
% Es el equivalente del programa binavg de la suite SBE 
% Data Procesing Win32, cuya formulacion se basa en la
% descripcion dada en los manuales de SBE de dicho programa
% para profundidades no interpoladas.
%
% Las variables de entrada son:
%
%    data = Matriz de datos de entrada (del cnv1)
% binsize = Definicion del promedio en db
%
% Las variables de salida son:
%
%  answ57 = Matriz de datos de salida correspondiente a los
%           perfiles de ascenso y descenso promediados det.
%           por <binsize>
%    desc = Perfil correspondiente al descenso
%    asce = Perfil de ascenso
%   align = Perfil promediado del descenso/ascenso (eq. al
%           programa align del SBE Data Prosc. Win32)

press=[0 10 30 50 75 100 150 200 250 300 400 500]; press=press';
bin_patron1=[0:binsize:600]; bin_patron1=bin_patron1';

max_press=max(data(:,1));

temp=(max_press.*ones(length(bin_patron1(:,1)),1))-bin_patron1;
[i1,j1]=find(temp>0); [i2,j2]=find(temp(i1)==min(temp(i1)));
top_bin=bin_patron1(i2);

bin_patron21=[binsize:binsize:top_bin]; bin_patron22=[(top_bin-binsize)*-1:binsize:-binsize];
bin_patron2=[bin_patron21';abs(bin_patron22')];

% Inicio del binavg

[i_maxdata,j_maxdata]=find(data(:,1)==max(data(:,1)));
diff_bin=diff(bin_patron2); diff_bin=[binsize;diff_bin];

j=1;
for i=1:length(bin_patron2(:,1))
    if diff_bin(j,1)>0 & bin_patron2(j,1)~=max(bin_patron2)
        temp=data(1:i_maxdata,:);
        BinMin=bin_patron2(j,1)-(binsize/2);
        BinMax=bin_patron2(j,1)+(binsize/2);
        if binsize==1 & j==1
            [i_d,j_d]=find(temp(:,1)>=1 & temp(:,1)<BinMax); 
            avg(j,:)=[bin_patron2(j,1),mean(temp(i_d,:),1)];
        else
            [i_d,j_d]=find(temp(:,1)>=BinMin & temp(:,1)<BinMax); 
            avg(j,:)=[bin_patron2(j,1),mean(temp(i_d,:),1)];
        end
    elseif bin_patron2(j,1)==max(bin_patron2)
        temp=data(:,:);
        BinMin=bin_patron2(j,1)-(binsize/2);
        BinMax=bin_patron2(j,1)+(binsize/2);
        [i_d,j_d]=find(temp(:,1)>=BinMin & temp(:,1)<BinMax);
        avg(j,:)=[bin_patron2(j,1),mean(temp(i_d,:),1)];
    elseif diff_bin(j,1)<0 & bin_patron2(j,1)~=max(bin_patron2)
        temp=data(i_maxdata:length(data(:,1)),:);
        BinMin=bin_patron2(j,1)-(binsize/2);
        BinMax=bin_patron2(j,1)+(binsize/2);
        [i_d,j_d]=find(temp(:,1)>=BinMin & temp(:,1)<BinMax);
        avg(j,:)=[bin_patron2(j,1),mean(temp(i_d,:),1)];
    end
    j=j+1;
end    

answ57=[avg];

[i,j]=find(answ57(:,1)==max(answ57(:,1))); 
desc=answ57(1:i,:); asce=[answ57(i,:);answ57(i+1:length(answ57(:,1)),:)]; asce=sortrows(asce,1);

[i_siz,j_siz]=size(desc);
for i=1:i_siz, align(i,:)=meanmiss([desc(i,:);asce(i,:)]);, end
