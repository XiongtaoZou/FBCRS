%%%%%%%%%%%%Reflexive fuzzy $\beta$-neighborhood operator%%%%%%%%%%%

function FBN = ReflexiveFBNO(X, Beta)

 [m, n] = size(X);
 
 cm1 = zeros(m, n);     % x的模糊β邻域系统的矩阵表示
 for i = 1:m
    for j = 1:n
        if X(i,j) >= Beta
            cm1(i,j) = 1;
        end    
    end
end 
% cm1
 
 cm2 = zeros(m, n);     % x的模糊β最小描述的矩阵表示(与其他几个相比必须是最小的)
 for i = 1:m
     for j = 1:n
         if cm1(i,j) == 1
             cmp = 1;
             for jj = 1:n
                 if cm1(i,jj) == 1
                     if (jj ~= j) && cmpFS(X(:,j), X(:,jj)) %比较两个模糊集的大小,即两个模糊集之间的包含关系
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

 FBN = zeros(m);        % 模糊β邻域(min)
 for i = 1:m
    if n == 1
        if cm2(i,1) == 1
        	for k = 1:m
            	FBN(i,k) = min(1, 1 - X(i,1) + X(k,1));
        	end
        end
    else
        clta = ones(n, m);  % 模糊β邻域的中间值(min)
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
