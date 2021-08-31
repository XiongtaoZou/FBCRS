%%%%%%%%%%%%Reflexive fuzzy $\beta$-neighborhood operator%%%%%%%%%%%

function FBN = ReflexiveFBNO(X, Beta)

 [m, n] = size(X);
 
 cm1 = zeros(m, n);     % x��ģ��������ϵͳ�ľ����ʾ
 for i = 1:m
    for j = 1:n
        if X(i,j) >= Beta
            cm1(i,j) = 1;
        end    
    end
end 
% cm1
 
 cm2 = zeros(m, n);     % x��ģ������С�����ľ����ʾ(������������ȱ�������С��)
 for i = 1:m
     for j = 1:n
         if cm1(i,j) == 1
             cmp = 1;
             for jj = 1:n
                 if cm1(i,jj) == 1
                     if (jj ~= j) && cmpFS(X(:,j), X(:,jj)) %�Ƚ�����ģ�����Ĵ�С,������ģ����֮��İ�����ϵ
                         cmp = 0;
                         break;
                     end 
                 end
             end
             if cmp == 1
             	cm2(i,j) = 1;   
             end   
         end
     end
 end
% cm2

 FBN = zeros(m);        % ģ��������(min)
 for i = 1:m
    if n == 1
        if cm2(i,1) == 1
        	for k = 1:m
            	FBN(i,k) = min(1, 1 - X(i,1) + X(k,1));
        	end
        end
    else
        clta = ones(n, m);  % ģ����������м�ֵ(min)
        for j = 1:n
            if cm2(i,j) == 1
                for k = 1:m
                    clta(j,k) = min(1, 1 - X(i,j) + X(k,j));
                end
            end
        end
        FBN(i,:) = min(clta);
    end
 end
% FBN

end
