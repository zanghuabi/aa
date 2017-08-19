%k������һ���ֶ�����
%data������Ĳ��������ŵ�����
%u��ÿһ�������
%re�Ƿ��صĴ������ŵ�����
function [u re]=KMeans(data,k)  
%****ÿ�δӵ�i��ȡ�������С��������k�����ĵĵ�i��ȡmi~ma�������
    [m n]=size(data);   %m�����ݸ�����n������ά��
    ma=zeros(n);        %ÿһά������,n*n��0����
    mi=zeros(n);        %ÿһά��С����
    u=zeros(k,n);       %�����ʼ�������յ�����ÿһ�������λ��
    for i=1:n
       ma(i)=max(data(:,i));    %�ҳ�ÿһά������������0����ĵ�i�еĵ�һ��λ��
       mi(i)=min(data(:,i));    %ÿһά��С����
       for j=1:k
            u(j,i)=ma(i)+(mi(i)-ma(i))*rand();  %���������ʼ��������������ÿһά[min max]�г�ʼ����Щ������mi(i)��ma(i)֮����������
       end      
    end
    
   %tpm{1*3}��һ�����飬ÿ��λ�ô���һ��300*3�ľ��󣬼�¼��Ԫ�������i�����ĵľ������
    while 1
        pre_u=u;            %��һ����õ�����λ��
        for i=1:k
            tmp{i}=[];      % ��ʽһ�е�x(i)-uj,Ϊ��ʽһʵ����׼��
            for j=1:m
                tmp{i}=[tmp{i};data(j,:)-u(i,:)];
            end
        end
   %�����ݽ��з���     
        quan=zeros(m,k);
        for i=1:m        %��ʽһ��ʵ��
            c=[];
            for j=1:k
                c=[c norm(tmp{j}(i,:))];%norm()�������������ŷ����þ���,����µľ�������c
            end
            [junk index]=min(c);%ȡ����С�ĸ�junk��indexָmin(c)���ڵ�λ��
            quan(i,index)=1; %Ϊ1��λ�þ��Ƕ�Ӧ���������ڵ���   
        end
  %���������½��м��㣬����Ϊ�����������Ԫ�ص������ֵ      
        for i=1:k            %��ʽ����ʵ��
           for j=1:n
                u(i,j)=sum(quan(:,i).*data(:,j))/sum(quan(:,i));
           end           
        end
        
        if norm(pre_u-u)<0.1  %���ϵ���ֱ��λ�ò��ٱ仯
            break;
        end
    end
    %������ȷ���������¼������о����Լ�����
    re=[];
    for i=1:m
        tmp=[];
        for j=1:k
            tmp=[tmp norm(data(i,:)-u(j,:))];%���¼���Ԫ���ݵ�k�������ĵ�ŷ�Ͼ���
        end
        [junk index]=min(tmp);
        re=[re;data(i,:) index];%��¼�����Լ���Ӧ���飬��n+1��������
    end
    
end