function RunFeature1Extraction()
fid=fopen('RunFeature1.txt','w+');%打开feature1.txt，用以储存特征1的数据
A=imread('out.jpg');%读入图片
t=graythresh(A); %取阈值
B=im2bw(A,t);%二值化，B为二值化后的图像矩阵，每个元素的值为0或1
[a,b]=size(B);
C=zeros(1,a+b);%定义特征向量

k=1;

for i=1:a
    for j=1:b
        if(B(i,j)==1)
            C(1,i)=C(1,i)+1;%如果行中的元素为白色，则增加1，最终结果为每一行的白点数
        end
    end
end

for j=1:b
    for i=1:a
        if(B(i,j)==1)
            C(1,a+j)=C(1,a+j)+1;%最终结果为每一列的白点数
        end
    end
end


fprintf(fid,'%d',k);
fprintf(fid,'%s','       ');
for i=1:a+b-1
  fprintf(fid,'%d',C(1,i));%将特征向量写入文本
  fprintf(fid,'%s',',');%用逗号隔开
end
if k~=1
fprintf(fid,'%d\n',C(1,a+b));%不为最后一行，则每行末尾加回车
else
fprintf(fid,'%d',C(1,a+b)); %最后一行则不加
end

fclose(fid);%关闭文件
