clear all;
path = "F:\PLG\PLG_66";
fileExt = '*.mat';
p = genpath(path);
length_p = size(p,2);
path = {};
temp = [];
file_list = [];
for i = 1:length_p
    if p(i) ~= ';'
        temp = [temp p(i)];
    else
        temp = [temp '\'];
        path = [path ; temp];
        temp = [];
    end
end

file_num = size(path,1); % 子文件夹的个数
% disp(file_num)
num = 1;
for i = 2:file_num
    disp("Patient number")
    disp(num2str(num))
    num = num + 1;
%     strcat(file_path,"label_nii\",aa,".nii");
    file_path =  path{i};
    labeldir = strcat(file_path,"label_nii");
%     disp(labeldir)
    if ~exist(labeldir)
       mkdir(labeldir);
    end
    disp("root_path_path is: ")
    disp(file_path)
    img_path_list = dir(strcat(file_path, fileExt));
    a = strcat(file_path, fileExt);
%     disp(a)
    img_num = length(img_path_list);
    disp("Number of .mat files :")
    disp(num2str(img_num))
    if img_num > 0
        for j = 1:img_num
%             disp("img_path_list")
            img_path_list_folder = img_path_list.folder;
%             disp(img_path_list_folder)
            image_name = img_path_list(j).name;
%             disp("image_name")
            disp(image_name)
            Data_roi=load(strcat(file_path,image_name));
            aaa = strcat(file_path,image_name);
            disp(aaa)
            label = Data_roi.Data_roi.roiimageMask;
            [m,n] = size(label);
            for item = 1:n
                if isempty(label{item})
                label{item} = zeros(300,300);
                else
                    label{item} = label{item}{1};
                    label{item} = rot90(label{item},3);
                end
            end
             f=cat(3,label{:});
             nii = make_nii(f, []);
             finalpath = split(image_name,".");
             aa = finalpath{1};
             finalpath = strcat(file_path,"label_nii\",aa,".nii");
             disp(finalpath)
             save_nii(nii, finalpath);
        end
    end
        
end

 








% Data_roi=load('E:\Program\Matlab2018a\Data_mat\PLGG019_ROI_TUMOR_FLAIR.mat');
% 
% label = Data_roi.Data_roi.roiimageMask;
% [m,n] = size(label);
% for i = 1:n
%     if isempty(label{i})
%         label{i} = zeros(300,300);
%     else
%         label{i} = label{i}{1};
%         label{i} = rot90(label{i},3);
%     end
% end
%  f=cat(3,label{:});
%  nii = make_nii(f, []);
%  save_nii(nii, 'label2.nii');
        









% 
% path = 'E:\Program\Matlab2018a\Data_mat';
% dirfile = dir(path);
% filename={dirfile.PLGG019_ROI_TUMOR_FLAIR};
% for i=2:length(filename)
%     dirzip=dir(fullfile(path, filename{i}, '*.mat'));
%         for j=1:length(zipname)
%             mat=load(fullfile(path,filename{i},zipname{j}(1:end-3)));
%             b=mat.f;
%             c=make_nii(b);
%             savepath=fullfile(path,filename{i},strcat(zipname{j}(1:end-4),'.nii.gz'));
%             save_nii(c,savepath)
%         end
% end
%  
 
% #nii2mat
% clear all;
% path = 'G:\Brats17-master\Brats17ValidationData'
% dirfile = dir(path);
% filename={dirfile.name};
% for i=3:length(filename) #从3开始是因为filename变量里有效文件名从3开始
%     dirzip=dir(fullfile(path, filename{i}, '*.gz'))
%     zipname={dirzip.name};
%         for j=1:length(zipname)
%             %gunzip(fullfile(path,filename{i},zipname{j}));
%             nii=load_nii(fullfile(path,filename{i},zipname{j}));
%             zipname{j}(1:end-3)
%             a=nii.img;
%             %a=strcat(zipname{j}(1:end-7),'.mat')
%             savepath=fullfile(path,filename{i},strcat(zipname{j}(1:end-7),'.mat'))
%             save(savepath,'a')
%         end
% end
