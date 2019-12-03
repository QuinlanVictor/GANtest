%%%copyimg1112测试程序  
%%%1203编辑：复制文件的主程序
close all;clear;clc;

xlsfilepathlist=uigetdir('E:\Study\Research\Data\Result\LIDC\dataframe');%选择文件夹
xlspathlist=dir(strcat(xlsfilepathlist,'\','*.xls'));

imgfolder='E:\Study\Research\Data\LIDC-JPG';
diary 'log1113.txt'
disp(' ');
time=clock;
t1=strcat(num2str(time(1)),'年',num2str(time(2)),'月',num2str(time(3)),'日',num2str(time(4)),'：',num2str(time(5)));
disp(['北京时间:',num2str(t1),'开始复制图片']);


for j=91:length(xlspathlist)
    tic;
    xlsname = xlspathlist(j).name;
    xlsfile=strcat(xlsfilepathlist,'\',xlsname);
    [a]=xlsread(num2str(xlsfile),1,'A1:A100');
    
    x=num2str(xlsname);
    split_xlsname=x(5:end-9);
    casename=strcat('case',num2str(split_xlsname));
    mkdirpath=strcat('E:\Study\Research\Data\Result\LIDC\copyimg\',num2str(casename));
    
    if isfolder(num2str(mkdirpath))
        disp([num2str(casename),'存在'])
        continue;
    end
    
    mkdir(num2str(mkdirpath));
    
    oldpath=num2str(mkdirpath);
    img_path=strcat(imgfolder,'\',num2str(casename));
    img_path_list = dir(strcat(imgfolder,'\',num2str(casename),'\','*.jpg'));% 获取该文件夹中所有格式的图像
    
    cd(num2str(img_path));
    for i=1:numel(a)
        b=a(i);
        imagename=sprintf('%d.jpg',b);
        copyfile(imagename,oldpath);
    end
    disp([num2str(xlsname),'复制图片完成，用时：',num2str(toc)]);
end

cd('E:\Study\Research\Repositories\YOLOv2test-master');

disp('完成复制，结束时间：');
showtime;
diary off
