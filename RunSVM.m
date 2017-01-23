function RunSVM()
clc; %清屏
clear all; %清缓

fid = fopen('RunFeature2.txt');
fout=fopen('RunSVMOut.txt','w+');

c = textscan(fid,'%f','delimiter',',');
d = c{1,1}; %因为新版建议用textscan，但textscan却要转一下
feature_matrix_predict = d'; % '代表将矩阵转置
feature_matrix_predict(:,[1])=[]; %去掉第一列的编号

% save model.mat model;
load('model2_Inv.mat','model');
fmp1=feature_matrix_predict(1,:);
predict_label = svmpredict(1, feature_matrix_predict, model); %看说明label是可以随意
predict_label

CharNo = [10 11 12 20 22 25 26 28 30 31 32 33 34];
CharTrans = ['京' '渝' '鄂' '0' '2' '5' '6' '8' 'A' 'B' 'C' 'D' 'Q'];
for i = 1:length(CharNo)
    if predict_label > 100
        predict_label = predict_label -100;
    end
    if predict_label == CharNo(i);
        fprintf(fout,'%s',CharTrans(i));
    end
end
