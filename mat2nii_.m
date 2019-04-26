clear all;
path = "F:\Test_426";
fileExt = '*.mat';
p = genpath(path);    %�õ���ǰĿ¼�µ������ļ��ĸ�Ŀ¼
list=dir(path);       % dir �г���ǰ�ļ����е��ļ����ļ���
fileNum=size(list,1)-2;
disp("There were 10 patients to process:...")
for k=3:size(list,1)
	disp(list(k).name);  % ������ļ�������������ļ��У���Ҳ����������
    sublist=dir(path + '\'+ list(k).name);
%     disp(path + '\'+ list(k).name + fileExt)
    img_path_list = dir(path + '\'+ list(k).name + "\"+fileExt);
%     disp(img_path_list);
    img_num = length(img_path_list);
    str_img_num = num2str(img_num);

    if img_num > 0
        for j = 1:img_num
            submat=path + '\'+ list(k).name + "\"+img_path_list(j).name;
            Data_roi=load(submat);
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
             finalpath = split(img_path_list(j).name,".");
             aaa = finalpath{1};
             file_path= path + '\'+ list(k).name;
             f_path = strcat(file_path,"\",aaa,".nii");
%              disp("finalpath")
%              disp(f_path)
             save_nii(nii, f_path)   
        end
    end

end
disp("All were successfully completed ,congratulate !")
