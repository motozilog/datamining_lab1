function PreProcessing()
[input1, input2, input3] = textread('Char_Index.txt','%d %d %s',1000, 'headerlines',1);
indexFileName = input3;
parfor k=1:1000
A=imread(strcat('Char_Image\',char(indexFileName(k,1)))); %读取图像
A=rgb2gray(A);
A=histeq(A); % 直方图均值化
A=medfilt2(A,[3 3]);
t=graythresh(A); %使用最大类间方差法来获得一个阈值，这个阈值在[0, 1]范围内。 该阈值可以传递给im2bw完成灰度图像转换为二值图像的操作。 最大类间方差法是一种自适应的阈值确定的方法,它是按图像的灰度特性,将图像分成背景和目标2部分。背景和目标之间的类间方差越大,说明构成图像的2部分的差别越大,当部分目标错分为背景或部分背景错分为目标都会导致2部分差别变小。因此,使类间方差最大的分割意味着错分概率最小。 
% A=adapthisteq(A); % 自适应直方图均值化
B=im2bw(A,t); %使用刚才的阈值转换成二值图像
[a,b]=size(B); %获取图像的大小

if(B(1,1)+B(1,b)+B(a,1)+B(a,b)>=2) %图像的四个角位，如果有2个以上是白色，就做图像的反相操作
    for i=1:a
        for j=1:b
            B(i,j)=1-B(i,j);
        end
    end
end
imwrite(B,strcat('Char_Image_Binary\',char(indexFileName(k,1)))); %写入二值图像
end
