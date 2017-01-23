function PreProcessingTo_Inv()
[input1, input2, input3] = textread('Char_Index.txt','%d %d %s',1000, 'headerlines',1);
indexFileName = input3;
%提示有14张图片是白底黑字的错误
parfor k=1:1000 %提示有14张图片是白底黑字的错误
A=imread(strcat('Char_Image_Binary\',char(indexFileName(k,1))));
t=graythresh(A); 
B=im2bw(A,t);
[a,b]=size(B);
for i=1:a
    for j=1:b
        B(i,j)=1-B(i,j); %明显这个又是反相
    end
end
imwrite(B,strcat('Char_Image_Binary_Inv\',char(indexFileName(k,1))));
end

