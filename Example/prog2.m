clc
clear
close all

%% Open frames
srcFiles = dir('/Users/didpurwanto/Documents/Dataset/Stabilized/Car_Hime_2_6450_6590/*.tif');  
totalFrame = length(srcFiles);

for i = 1 : totalFrame
    time = i;
    filename = strcat('/Users/didpurwanto/Documents/Dataset/Stabilized/Car_Hime_2_6450_6590/',srcFiles(i).name);
    img = imread(filename);

    %Convert to grayscale
    if size(img,3)
        im=rgb2gray(img);
    end
    
    %Create multidemensional data from each frame
    I(:,:,time) = im;
end

%% Harris feature interest point using MATLAB
% corners = detectHarrisFeatures(I(:,:,1));
% [features, valid_corners] = extractFeatures((I(:,:,1)), corners);
% figure; imshow((I(:,:,1))); hold on
% plot(valid_corners);

%% Toolbox Feature Descriptor
% stfeature using Harris Detector
[R,subs,vals,cuboids,V] = stfeatures( I, 2, 3, 0, eps, [], 1.85, 2, 1, 5 );

% imagedesc_generate
iscuboid = 1;  histFLAG = 3;  jitterFLAG = 0; 
imdescGRAD = imagedesc_generate( iscuboid, 'GRAD' , histFLAG, jitterFLAG );
imdescFLOW = imagedesc_generate( iscuboid, 'FLOW' , histFLAG, jitterFLAG );

%imagedesc
descGRAD = imagedesc(cuboids,imdescGRAD,0);
descFLOW = imagedesc(cuboids,imdescFLOW,0);

%save to mat
save('Car_Hime_2_6450_6590.mat','descFLOW','descGRAD');
