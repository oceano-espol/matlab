function plot_test

opengl software;

date=datevec(now);

contourf(peaks), colorbar

text(.1,.8,{'Hello world!','Knowledge is power.'},'horizontalalignment',...
    'left','units','normalized'),
print('-djpeg','-r300',['/home/jonathan/printing_test_',...
    num2str(date(1),'%04.0f'),num2str(date(2),'%02.0f'),num2str(date(3),'%02.0f'),'_',...
    num2str(date(4),'%02.0f'),num2str(date(5),'%02.0f'),num2str(date(6),'%02.0f')]),

quit