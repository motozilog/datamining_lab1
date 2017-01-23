clc; %清屏
clear all; %清缓存
ferror = fopen('error.txt','w+');

for file=1:6
    feature_name=strcat('feature',num2str(file));
    feature_name=strcat(feature_name,'_Inv.txt');
    fprintf(ferror,'%s\n',feature_name);

% fid = fopen('feature1_Inv.txt');
fid = fopen(feature_name);
C = textscan(fid,'%d','delimiter',',');
D = C{1,1}; %因为新版建议用textscan，但textscan却要转一下
clear feature_matrix;
clear feature_matrix_train;
clear feature_matrix_predict;
feature_matrix = zeros(2000,length(D)/2000);
for i = 1:2000
    for j = 1:(length(D)/2000)
        feature_matrix(i,j) = D(j+(i-1)*(length(D)/2000));
    end
end
feature_matrix(:,[1])=[]; %去掉第一列的编号

[input1, input2, input3] = textread('Char_Index.txt','%d %d %s',1000, 'headerlines',1);%读取图片的编号，类别信息和文件名
indexFileName = [input3;input3];%复制1000
char_index = [input2;input2];
char_file_name = [input3;input3];

char_index_predict = zeros(400,1);
char_file_name_predict = {};
char_index_train = zeros(1600,1);
it=1;
ip=1;
for i =1:2000
    if rem(i,5)==0
        if i < 1001
            char_index_predict(ip) = char_index(i);
        else
            char_index_predict(ip) = char_index(i) + 100;
        end
        char_file_name_predict(ip) = char_file_name(i);
        feature_matrix_predict(ip,:) = feature_matrix(i,:); %按行复制
        ip = ip+1;
    else
        if i < 1001
            char_index_train(it) = char_index(i);
        else
            char_index_train(it) = char_index(i) + 100;
        end
        feature_matrix_train(it,:) = feature_matrix(i,:); %按行复制
        it = it+1;
    end
end

% model = svmtrain(char_index, feature_matrix);
% [predict_label, accuracy, dec_values] = svmpredict(char_index, feature_matrix, model);

model = svmtrain(char_index_train,  feature_matrix_train,'-t 1 -d 3 -g 0.01 -r 2');

model_name=strcat('model',num2str(file));
model_name=strcat(model_name,'_Inv.mat');
save (model_name,'model');
% load model.mat model;

[predict_label, accuracy, dec_values] = svmpredict(char_index_predict, feature_matrix_predict, model);
% fprintf(ferror,'acc:%f\n',accuracy(1,1));

noCorrect = []; %初始化

CharNo = [10 11 12 20 22 25 26 28 30 31 32 33 34];
CharTrans = ['京' '渝' '鄂' '0' '2' '5' '6' '8' 'A' 'B' 'C' 'D' 'Q'];

noCorrect_count=0;
for i = 1:400
    if char_index_predict(i) > 100
        char_index_predict_temp = char_index_predict(i) -100;
    else
        char_index_predict_temp = char_index_predict(i);
    end

    if predict_label(i) > 100
        predict_label_temp = predict_label(i) -100;
    else
        predict_label_temp = predict_label(i);
    end
    
    
    if char_index_predict_temp ~= predict_label_temp %matlab取反是~而不是!
        noCorrect_count = noCorrect_count+1;
        noCorrect =[noCorrect; i char_file_name_predict(i) char_index_predict(i) predict_label(i)];

        for k = 1:length(CharNo)
            if char_index_predict_temp == CharNo(k);
                char_index_predict_char = CharTrans(k);
            end
        end

        for k = 1:length(CharNo)
            if predict_label_temp == CharNo(k);
                predict_char = CharTrans(k);
            end
        end
        fprintf(ferror, '%d %s %d:%s %d:%s\n', i, char(char_file_name_predict(i)),char_index_predict(i),char_index_predict_char, predict_label(i),predict_char);
    end
end

fprintf(ferror, 'Correct %f\n\n',((400-noCorrect_count)/400)*100); %正确率

noCorrect
end

fclose(ferror);
