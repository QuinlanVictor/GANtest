%%%copyimg1112���Գ���  
%%%1203�༭�������ļ���������
close all;clear;clc;

xlsfilepathlist=uigetdir('E:\Study\Research\Data\Result\LIDC\dataframe');%ѡ���ļ���
xlspathlist=dir(strcat(xlsfilepathlist,'\','*.xls'));

imgfolder='E:\Study\Research\Data\LIDC-JPG';
diary 'log1113.txt'
disp(' ');
time=clock;
t1=strcat(num2str(time(1)),'��',num2str(time(2)),'��',num2str(time(3)),'��',num2str(time(4)),'��',num2str(time(5)));
disp(['����ʱ��:',num2str(t1),'��ʼ����ͼƬ']);


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
        disp([num2str(casename),'����'])
        continue;
    end
    
    mkdir(num2str(mkdirpath));
    
    oldpath=num2str(mkdirpath);
    img_path=strcat(imgfolder,'\',num2str(casename));
    img_path_list = dir(strcat(imgfolder,'\',num2str(casename),'\','*.jpg'));% ��ȡ���ļ��������и�ʽ��ͼ��
    
    cd(num2str(img_path));
    for i=1:numel(a)
        b=a(i);
        imagename=sprintf('%d.jpg',b);
        copyfile(imagename,oldpath);
    end
    disp([num2str(xlsname),'����ͼƬ��ɣ���ʱ��',num2str(toc)]);
end

cd('E:\Study\Research\Repositories\YOLOv2test-master');

disp('��ɸ��ƣ�����ʱ�䣺');
showtime;
diary off