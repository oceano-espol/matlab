% lc_examen_desc
%
% 7-dec-2016


dtes=nanfill(dtes,-999.9);
dtpl=nanfill(dtpl,-999.9);
dtsl=nanfill(dtsl,-999.9);

landscape, orient landscape,
subplot(131),
plot(dtes(:,5),dtes(:,3)); grid on,
ylabel('Profundidad [m]'),
set(gca,'ylim',[-120,0],'xlim',[32,35.5],'xtick',[32:0.5:35.5]),
subplot(132),
plot(dtpl(:,5),dtpl(:,3)); grid on,
xlabel('Salinidad [ups]'),
set(gca,'ylim',[-120,0],'xlim',[32,35.5],'xtick',[32:0.5:35.5]),
subplot(133),
plot(dtsl(:,5),dtsl(:,3)); grid on,
set(gca,'ylim',[-120,0],'xlim',[32,35.5],'xtick',[32:0.5:35.5]),
print '-djpeg' 'examenDesc'
