function Feature5Extraction_Inv()
[input1, input2, input3] = textread('Char_Index.txt','%d %d %s',1000, 'headerlines',1);%读取图片的编号，类别信息和文件名
indexFileName = [input3;input3];%复制1000
fid=fopen('feature5_Inv.txt','w+');%打开feature1.txt，用以储存特征1的数据

step = 4; %设置方块步长
for k=1:2000 %共2000个图片
    if k<1001
        A=imread(strcat('Char_Image_Binary\',char(indexFileName(k,1))));%读入图片
    else
        A=imread(strcat('Char_Image_Binary_Inv\',char(indexFileName(k,1))));%读入图片
    end
t=graythresh(A); %取阈值
B=im2bw(A,t);%二值化，B为二值化后的图像矩阵，每个元素的值为0或1
[a,b]=size(B);
countSquare = ceil(a/step) * ceil (b/step); %ceil为向上取整，计算共多少个方块

fprintf(fid,'%d',k);
fprintf(fid,'%s','       ');

count = 0; %方块计数
for i = 1:step:a
    for j = 1:step:b
        temp = 0; %白点计数
        count = count+1;
        
        %不是满step的也要计
        if(a-i > step)
            i2f = step;
        elseif(a-i < step)
            i2f = a-i+1;
        end

        if(b-j > step)
            j2f = step;
        else
            j2f = b-j+1;
        end
        
        for i2 = 0:i2f-1
            for j2 = 0:j2f-1
                if(B(i+i2,j+j2) == 1)
                  temp = temp+1;%方块中白色计数
                end
            end
        end
        %调试用
%         fprintf(fid,'%d',i2f);
%         fprintf(fid,'*');
%         fprintf(fid,'%d',j2f);
%         fprintf(fid,':');

        fprintf(fid,'%d',temp);        
        if(countSquare ~= count)
            fprintf(fid,',');
%             fprintf(fid,'\t');
        end
    end
end
%调试用
% fprintf(fid,'count:');
% fprintf(fid,'%d',count);
% fprintf(fid,'\n');

if k~=2000
fprintf(fid,'\n');%不为最后一行，则每行末尾加回车
end

end
fclose(fid);%关闭文件
