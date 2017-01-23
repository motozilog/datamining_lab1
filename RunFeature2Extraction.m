function RunFeature2Extraction()
fid=fopen('Runfeature2.txt','w+');

step = 8; %设置方块步长
k=1;
A=imread('out.jpg');%读入图片
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

if k~=1
fprintf(fid,'\n');%不为最后一行，则每行末尾加回车
end

fclose(fid);%关闭文件
