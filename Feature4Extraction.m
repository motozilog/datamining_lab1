function Feature4Extraction()
[input1, input2, input3] = textread('Char_Index.txt','%d %d %s',1000, 'headerlines',1);%读取图片的编号，类别信息和文件名
indexFileName = input3;%获得文件名
fid=fopen('feature4.txt','w+');%打开feature1.txt，用以储存特征1的数据
for k=1:1000 %共1000个图片
A=imread(strcat('Char_Image_Binary\',char(indexFileName(k,1))));%读入图片
t=graythresh(A); %取阈值
B=im2bw(A,t);%二值化，B为二值化后的图像矩阵，每个元素的值为0或1
[a,b]=size(B);

fprintf(fid,'%d',k);
fprintf(fid,'%s','       ');

%逐行统计线段数
temp=0; %使用temp作为标记是否连续
for i=1:a
    line=0;
    for j=1:b
        if(B(i,j)==1)&(temp==0)
            line=line+1;
            temp=1; %置位避免重复记数
        elseif(B(i,j)==0)&(temp==1)
            temp=0;
        end
    end
    fprintf(fid,'%d',line);
    fprintf(fid,',');
end

%逐列统计线段数
temp=0; %使用temp作为标记是否连续
for j=1:b
    line=0;
    for i=1:a
        if(B(i,j)==1)&(temp==0)
            line=line+1;
            temp=1; %置位避免重复记数
        elseif(B(i,j)==0)&(temp==1)
            temp=0;
        end
    end
    fprintf(fid,'%d',line);
    
    if (j ~=b)
        fprintf(fid,',');
    end
end

if k~=1000
fprintf(fid,'\n');%不为最后一行，则每行末尾加回车
end

end
fclose(fid);%关闭文件
