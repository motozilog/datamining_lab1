tic;
PreProcessing();%预处理，把要处理的图像转化成二值图
PreProcessingToCorrect();%对没有正确转化的图像进行手工校正
PreProcessingTo_Inv();%对没有正确转化的图像进行手工校正

% Feature1Extraction_Inv();%提取特征1，为每一行和每一列的白点数
% Feature2Extraction_Inv();%提取特征2，为区域密度，区域大小为8*8
% Feature3Extraction_Inv();%提取特征3，为字符左右上下与边界的距离，
% Feature4Extraction_Inv();%提取特征4，为每一行和每一列的线段数目
% Feature5Extraction_Inv();%提取特征5，为区域密度，区域大小为4*4
% Feature6Extraction_Inv();%提取特征6，为区域密度，区域大小为6*6

%多线程执行
funList = {@Feature1Extraction_Inv,@Feature2Extraction_Inv,@Feature3Extraction_Inv,@Feature4Extraction_Inv,@Feature5Extraction_Inv,@Feature6Extraction_Inv};
% parpool open 

parfor i=1:length(funList)
    %# call the function
    funList{i}();
end


train_inv();
toc%计算程序运行时间