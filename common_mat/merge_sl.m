function [tm,dt]=merge_sl(tm1,dt1,tm2,dt2)
% function [tm,dt]=merge_sl(tm1,dt1,tm2,dt2)
%
% MERGE_SL Union de series de tiempo
%          *ideado para el SL de Aviso (DT & NRT)

tm1_max=tm1(end);
tm2_min=tm2(1);

tm_gap=[tm1_max+1:1:tm2_min-1]';
dt_gap=ones(length(tm_gap),1).*NaN;

tm=[tm1;tm_gap;tm2];
dt=[dt1;dt_gap;dt2];