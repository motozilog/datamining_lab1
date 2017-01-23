function PreProcessingToCorrect()
[input] = textread('Char_Index_Err.txt','%s',14);
%提示有14张图片是白底黑字的错误
indexFileName = input;
for k=1:14 %提示有14张图片是白底黑字的错误
A=imread(strcat('Char_Image_Binary\',char(indexFileName(k,1))));
t=graythresh(A); 
B=im2bw(A,t);
[a,b]=size(B);
for i=1:a
    for j=1:b
        B(i,j)=1-B(i,j); %明显这个又是反相
    end
end
imwrite(B,strcat('Char_Image_Binary\',char(indexFileName(k,1))));
end

A=imread('Char_Image\20090109154704265ch1IMG.JPG');
B=im2bw(A,0.1);
imwrite(B,'Char_Image_Binary\20090109154704265ch1IMG.JPG');

% A=imread('Char_Image\20081130163845687ch1IMG.JPG');
% A=rgb2gray(A); %用直方图均值化前要先转成灰阶图
% % A=adapthisteq(A); %自适应直方图均值化
% A=histeq(A); %直方图均值化
% % A=medfilt2(A,[3 3]); %中值滤波
% imwrite(A,'Char_Image_Binary\20081130163845687ch1IMG.JPG');
% imshow (A)
