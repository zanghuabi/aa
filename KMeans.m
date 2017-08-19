%k是数据一共分多少类
%data是输入的不带分类标号的数据
%u是每一类的中心
%re是返回的带分类标号的数据
function [u re]=KMeans(data,k)  
%****每次从第i列取出最大最小数，并对k个质心的第i列取mi~ma的随机数
    [m n]=size(data);   %m是数据个数，n是数据维数
    ma=zeros(n);        %每一维最大的数,n*n的0矩阵
    mi=zeros(n);        %每一维最小的数
    u=zeros(k,n);       %随机初始化，最终迭代到每一类的中心位置
    for i=1:n
       ma(i)=max(data(:,i));    %找出每一维最大的数，放在0矩阵的第i行的第一个位置
       mi(i)=min(data(:,i));    %每一维最小的数
       for j=1:k
            u(j,i)=ma(i)+(mi(i)-ma(i))*rand();  %质心随机初始化，不过还是在每一维[min max]中初始化好些，产生mi(i)到ma(i)之间的随机数。
       end      
    end
    
   %tpm{1*3}是一个数组，每个位置存了一个300*3的矩阵，记录了元数据与第i个质心的距离矩阵
    while 1
        pre_u=u;            %上一次求得的中心位置
        for i=1:k
            tmp{i}=[];      % 公式一中的x(i)-uj,为公式一实现做准备
            for j=1:m
                tmp{i}=[tmp{i};data(j,:)-u(i,:)];
            end
        end
   %对数据进行分组     
        quan=zeros(m,k);
        for i=1:m        %公式一的实现
            c=[];
            for j=1:k
                c=[c norm(tmp{j}(i,:))];%norm()计算的是向量的欧几里得距离,组成新的距离向量c
            end
            [junk index]=min(c);%取出最小的给junk，index指min(c)所在的位置
            quan(i,index)=1; %为1的位置就是对应的数据所在的组   
        end
  %对质心重新进行计算，质心为所在组的所有元素的坐标均值      
        for i=1:k            %公式二的实现
           for j=1:n
                u(i,j)=sum(quan(:,i).*data(:,j))/sum(quan(:,i));
           end           
        end
        
        if norm(pre_u-u)<0.1  %不断迭代直到位置不再变化
            break;
        end
    end
    %新质心确定后，再重新计算所有距离以及分组
    re=[];
    for i=1:m
        tmp=[];
        for j=1:k
            tmp=[tmp norm(data(i,:)-u(j,:))];%重新计算元数据到k个组质心的欧氏距离
        end
        [junk index]=min(tmp);
        re=[re;data(i,:) index];%记录数据以及对应的组，第n+1列是组数
    end
    
end