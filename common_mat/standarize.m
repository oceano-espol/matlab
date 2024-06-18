function [answ78,mean_data,std_data]=standarize(data)
%function answ78=standarize(data)
% 
% <STANDARIZE> Estandarizar datos
% 
% Los datos deben de estar listados en la dimensión de las filas. Si
% existen uno o más juego de datos, deben de ser dispuestos a 
% continuanción de una columna.

warning off MATLAB:divideByZero

[i,j]=size(data);

if j==1
    std_data=stdmiss(data);
    mean_data=meanmiss(data);
    answ78=(data-mean_data)./std_data;
elseif j>1
    for i=1:j
        std_data=[]; mean_data=[];
        std_data=stdmiss(data(:,i));
        mean_data=meanmiss(data(:,i));
        answ78(:,i)=(data(:,i)-mean_data)./std_data;
    end
end