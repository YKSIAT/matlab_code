clear all;
clc;

addpath('E:\daima\')
addpath('E:\Program\Matlab2018a\');
addpath('E:\daima\DATA');
addpath('E:\daima\MedicalImageProcessingToolbox');
addpath('E:\daima\MedicalImageProcessingToolbox\class_image');
addpath('E:\daima\MedicalImageProcessingToolbox\class_mesh');
addpath('E:\daima\MedicalImageProcessingToolbox\processing\Basic');
addpath('E:\daima\MedicalImageProcessingToolbox\processing\Geometry');
addpath('E:\daima\MedicalImageProcessingToolbox\processing\IO');
addpath('E:\daima\MedicalImageProcessingToolbox\processing\Meshes');
addpath('E:\daima\MedicalImageProcessingToolbox\processing\Misc');
addpath('E:\daima\MedicalImageProcessingToolbox\processing\Sources');
addpath('E:\daima\MedicalImageProcessingToolbox\processing\Visu');
[img, info]=read_mha('T1mut.mha');

%  nii=load_nii( 'E:\Program\Matlab2018a\T1.nrrd' )
 volume = img;
             data = double(img.data);
             [a,b,c]=size(data);
             Im=zeros(a,b,c);
             In=zeros(a,b,c);
   for n = 40 : 90
    for m =75 :130
        for k = 22 :24
%   for n = 85 : 135
%     for m =95 :150
%         for k = 24 :26%选定计算纹理的区域   

            part = data(n-1:n+1, m-1:m+1, k-1:k+1);%选取计算纹理特征的
            [texture] = getGlobalTextures(part);
% In(n,m,k)=texture.Skewness;
            data(n,m,k)=texture.Root_mean_square;
            Im(n,m,k)=texture.Energy;
        end
    end
  end
Anecrotic.data=Im;
Anecrotic.size = img.size;
Anecrotic.origin = img.origin;
Anecrotic.spacing = img.spacing;
Anecrotic.orientation = img.orientation;
Anecrotic.D = img.D;
Anecrotic.paddingValue = img.paddingValue;
Anecrotic.MAX_CHUNK_SIZE = img.MAX_CHUNK_SIZE;
write_mhd('E:\featuremap\MUT\t1energy.mha',Anecrotic);
