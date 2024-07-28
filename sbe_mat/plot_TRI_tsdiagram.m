function plot_TRI_tsdiagram(data,meses)
%function plot_TRI_tsdiagram(data)
% 
% PRUEBA!!!

% plot para los diagramas TS

% VHS Lluviosa (1) / IHS Seca (2)

legend_tri={'b','r','k'};

% ESM
[i1,j1]=find(data(:,1)==1); data_1_esm=data(i1,:);
[i2,j2]=find(data_1_esm(:,2)==meses(1) |...
    data_1_esm(:,2)==meses(2) | data_1_esm(:,2)==meses(3));
data_1_esm_MO=data_1_esm(i2,:);  % pause

% PLP
[i1,j1]=find(data(:,1)==2); data_2_plp=data(i1,:);
[i2,j2]=find(data_2_plp(:,2)==meses(1) |...
    data_2_plp(:,2)==meses(2) | data_2_plp(:,2)==meses(3));
data_2_plp_MO=data_2_plp(i2,:);     % pause

% SAL
[i1,j1]=find(data(:,1)==3); data_3_sal=data(i1,:);
[i2,j2]=find(data_3_sal(:,2)==meses(1) |...
    data_3_sal(:,2)==meses(2) | data_3_sal(:,2)==meses(3));
data_3_sal_MO=data_3_sal(i2,:);     % pause

subplot(3,1,1), portrait
for i=1:3
    
    if i==1,
        for i_1=1:3
            [ii_1,jj_1]=find(data_1_esm_MO(:,2)==meses(i_1));
            plot(data_1_esm_MO(ii_1,4),data_1_esm_MO(ii_1,5),legend_tri{i_1}), hold on,
        end
    end
    
    [ii,jj]=find(data_1_esm_MO(:,2)==meses(i));    
    if i==1, 
        masasp([data_1_esm_MO(ii,5),data_1_esm_MO(ii,4)],1); hold on, 
    else
        plot(data_1_esm_MO(ii,4),data_1_esm_MO(ii,5),legend_tri{i})
    end
    
end

legend('Marzo','Abril','Mayo','location','SW')
title('ESMERALDAS','fontsize',12,'fontweight','bold'), xlabel(''),

subplot(3,1,2),
for i=1:3
    
    if i==1,
        for i_1=1:3
            [ii_1,jj_1]=find(data_2_plp_MO(:,2)==meses(i_1));
            plot(data_2_plp_MO(ii_1,4),data_2_plp_MO(ii_1,5),legend_tri{i_1}), hold on,
        end
    end
    
    [ii,jj]=find(data_2_plp_MO(:,2)==meses(i));    
    if i==1, 
        masasp([data_2_plp_MO(ii,5),data_2_plp_MO(ii,4)],1); hold on, 
    else
        plot(data_2_plp_MO(ii,4),data_2_plp_MO(ii,5),legend_tri{i})
    end
    
end

legend('Marzo','Abril','Mayo','location','SW')
title('PUERTO LOPEZ','fontsize',12,'fontweight','bold'), xlabel(''),
    
subplot(3,1,3),
for i=1:3
    
    if i==1,
        for i_1=1:3
            [ii_1,jj_1]=find(data_3_sal_MO(:,2)==meses(i_1));
            plot(data_3_sal_MO(ii_1,4),data_3_sal_MO(ii_1,5),legend_tri{i_1}), hold on,
        end
    end
    
    [ii,jj]=find(data_3_sal_MO(:,2)==meses(i));    
    if i==1, 
        masasp([data_3_sal_MO(ii,5),data_3_sal_MO(ii,4)],1); hold on, 
    else
        plot(data_3_sal_MO(ii,4),data_3_sal_MO(ii,5),legend_tri{i})
    end
    
end

legend('Marzo','Abril','Mayo','location','SW')
title('SALINAS','fontsize',12,'fontweight','bold'), % xlabel(''),
