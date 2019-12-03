clear;clc;
xlsfolder = uigetdir('E:\Study\Research\Data\Result\LIDC');
xlsfolderlist = dir(xlsfolder);
%imgfolderpath='E:\Study\Research\Data\Result\LIDC\copyimg';
%imgfolderpath='E:\Study\Research\Data\Result\LIDC\testdata\testcase';
imgfolderpath='F:\Data\copyimgtest';
%copypath='E:\Study\Research\Data\Result\LIDC\testdata\testimg';
copypath='E:\Study\Research\Data\Result\LIDC\traningdata\dataimg';

diary 'log1113.txt'
disp(' ');
showtime;

m=0;
x=[];
numj=[];
numy=[];
%for k=3:length(xlsfolderlist)
for k=3:length(xlsfolderlist)
    
    a=xlsfolderlist(k).name;
    xlspath=strcat(xlsfolder,'\',a);
    [c]=xlsread(num2str(xlspath),1,'A1:A100');
    [d]=xlsread(num2str(xlspath),1,'B1:E100');
    split_foldername=a(1:end-9);
    
    imgfolder=strcat(imgfolderpath,'\',num2str(split_foldername));
    imglist=dir(strcat(imgfolderpath,'\',num2str(split_foldername),'\','*.jpg'));
    
    cd(num2str(imgfolder));
    for i=1:length(imglist)
        j=i+m;
        oldname=imglist(i).name;
        b=oldname(isstrprop(oldname,'digit'));
        newname=num2str(j,'%04d.jpg');
        cmd=['rename ',oldname,' ', newname];
        status = system(cmd);
        if status~=0
            disp([num2str(imgfolder),num2str(oldname),'修改不成功!']);
        end
        copyfile(newname,copypath);
        x=[x();str2num(b)];
        numj=[numj();j];
    end
    m=m+i;
    
    for n=1:i
        for s=1:numel(c)
            if x(n)==c(s)
                numy=[numy();numj(n),d(s,:)];
            end
        end
    end
    %numy=[numy();y];
    disp([num2str(imgfolder),'完成']);
  
end
disp('完成');

cd('E:\Study\Research\Data\Result\LIDC\testdata\testxls2');
xlswrite('test1113.xls',numy);

diary off
