function [answ57,desc,asce,align]=binavg(data,binsize)
%function [answ57,desc,asce,align]=binavg(data,binsize)
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

% whos bin_patron1 bin_patron2 avg
% bin_patron2, avg, pause,

[i,j]=find(answ57(:,1)==max(answ57(:,1))); 
desc=answ57(1:i,:); asce=[answ57(i,:);answ57(i+1:length(answ57(:,1)),:)]; asce=sortrows(asce,1);

[i_siz,j_siz]=size(desc);
for i=1:i_siz, align(i,:)=meanmiss([desc(i,:);asce(i,:)]);, end

% diff_data2=diff(data2_temp(:,1)); 
% [i_diff,j_diff]=find(diff_data2~=0);
% 
% block1=[i_diff;length(data2_temp)]; block2=[1;i_diff+1];
% block_def=[block2,block1];
% 
% j=1;
% for i=1:length(block_def)
%     tempy=[];
%     tempy=data2_temp(block_def(j,1):block_def(j,2),:);
%     mean_blocky(j,:)=mean(tempy);
%     j=j+1
% end