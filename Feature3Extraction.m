function Feature3Extraction()
[input1, input2, input3] = textread('Char_Index.txt','%d %d %s',1000, 'headerlines',1);%读取图片的编号，类别信息和文件名
indexFileName = input3;%获得文件名
fid=fopen('feature3.txt','w+');%打开feature1.txt，用以储存特征1的数据

for k=1:1000 %共1000个图片
A=imread(strcat('Char_Image_Binary\',char(indexFileName(k,1))));%读入图片
t=graythresh(A); %取阈值
B=im2bw(A,t);%二值化，B为二值化后的图像矩阵，每个元素的值为0或1
[a,b]=size(B);

fprintf(fid,'%d',k);
fprintf(fid,'%s','       ');

%首次出现白点位置-左
% fprintf(fid,'L ');
for i = 1:a
    temp = 0; %首次出现白点位置
    for j = 1:b
        if(B(i,j) == 1)
            fprintf(fid,'%d,',temp);
            break;
        else
            temp = temp+1;
        end
    end
    
    if(temp == b)
            fprintf(fid,'%d,',b);
    end
 end

%首次出现白点位置-右
% fprintf(fid,'R ');
for i = 1:a
    temp = 0; %首次出现白点位置
    for j = b:-1:1
        if(B(i,j) == 1)
            fprintf(fid,'%d,',temp);
            break;
        else
            temp = temp+1;
        end
    end
    
    if(temp == b)
            fprintf(fid,'%d,',b);
    end
 end

%首次出现白点位置-上
% fprintf(fid,'U ');
for j = 1:b
    temp = 0; %首次出现白点位置
    for i = 1:a
        if(B(i,j) == 1)
            fprintf(fid,'%d,',temp);
            break;
        else
            temp = temp+1;
        end
    end
    
    if(temp == a)
            fprintf(fid,'%d,',a);
    end
end

%首次出现白点位置-下
% fprintf(fid,'D ');
for j = 1:b
    temp = 0; %首次出现白点位置
    for i = a:-1:1
        if(B(i,j) == 1)
            fprintf(fid,'%d',temp);
            break;
        else
            temp = temp+1;
        end
    end
    
    if(temp == a)
            fprintf(fid,'%d',a);
    end
    
    if(j ~= b)
        fprintf(fid,',');
    end
end

if k~=1000
fprintf(fid,'\n');%不为最后一行，则每行末尾加回车
end

end
fclose(fid);%关闭文件
