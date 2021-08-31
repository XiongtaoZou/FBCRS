%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project name:  Fuzzy $\beta$-covering rough set models
% Coding author: ZouXiongTao
% Email address: zxt_hnnu@163.com
% Conding date:  06/21/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear; close all;

% data = [4 6 4 7 1
%         5 4 5 8 1
%         3 4 5 3 2
%         8 4 6 4 3];     % The decision table (U, C_\beta, D)
load wine 
data = [attributes class];    

C = data(:,1:end-1);	% The conditional attribute set $C_\beta$
D = data(:,end);        % The decision attribute D

Beta = 0.001;             %%%%%%%%%% The parameter $\beta$ %%%%%%%%%%
[m, n] = size(data);

DCT = zeros(m);         % Temp of the decision equivalence class $D_i$
for i = 1:m
    for j = 1:m
        if D(i) == D(j)
            DCT(i,j) = 1;
        end
    end
end
% DCT
DC = [];                % The decision equivalence class $D_i$
for i = 1:m
    n1 = size(DC,1);
    flag1 = 1;
    for j = 1:n1
        if equalFS(DCT(i,:), DC(j,:))
            flag1 = 0;
            break;
        end
    end
    if flag1
        DC = [DC; DCT(i,:)];
    end
end
% DC

%% 0.Data normalization for the conditional attribute set.
% disp('-----------------Data normalization---------------------');
% A = (C - repmat(min(C),m,1)) ./ repmat(max(C)-min(C),m,1);
A = C ./ repmat(sqrt(sum(C.^2)),m,1);
% A


%% 1.Attribute reduction
flagRed = zeros(1,n-1);
Red = [];	% One reduct
reduct = [];
flagB = ones(1,n-1);
% B = A;      % The fuzzy $\beta$-covering subset $B_\beta$ of $C_\beta$
% B = dealingSubset(flagB, A);
LMaxDD = 0; % Last maximum dependency degree
while(isNotEmpty(flagB))
%     disp('-----------------1---------------------');
    MaxDD = 0;	% Maximal dependency degree in $B_\beta$
    MaxDDj = 0; % Index of maximal dependency degree in $B_\beta$
    for j = 1:n-1
        if flagB(j) == 1
    % 1. Calculate the fuzzy similarity class (or the fuzzy $\beta$-covering
    % relation) w.r.t. the fuzzy $\beta$-covering subset $red ¡È C$.
%             mBeta = maxBeta([Red A(:,j)]);
%             mBeta
            FBN = ReflexiveFBNO([Red A(:,j)], Beta);
%             FBN
            R = min(FBN, FBN'); % The fuzzy similarity class(object*object)
            % R = max(FBN, FBN');
%             R
            
    % 2. Calculate the lower approximation of the decision class $D_i$ 
    % w.r.t. the fuzzy $\beta$-covering subset $red ¡È C$.
            n2 = size(DC,1);
            LAD = zeros(n2,m); % class * object
            for ii = 1:n2
                % DC(ii,:) = [1 1 0 0]; % The decision class $D_i$
                LAT = zeros(m); % Temp of the lower approximation of $D_i$ 
                for i = 1:m
                    LAT(i,:) = max(1 - R(i,:), DC(ii,:));
                end
                LAD(ii,:) = min(LAT'); % The lower approximation of $D_i$
            end
%             LAD
            
    % 3. Calculate the fuzzy positive region of D w.r.t. the fuzzy 
    % $\beta$-covering subset $red ¡È C$.
            if n2 == 1
                POS = LAD;
            else
                POS = max(LAD);
            end
%             POS 
            
    % 4. Calculate the fuzzy dependency function of D w.r.t. the fuzzy 
    % $\beta$-covering subset $red ¡È C$.
            DD = sum(POS) / m;
%             DD
            
            if DD > MaxDD
                MaxDD = DD;
            	MaxDDj = j;
            end
            %break; %%%%%%%%%%%%%%%%%%%%%%%test%%%%%%%%%%%%%%%%%%%%
        end
    end
    
    % 5. Calculate the fuzzy dependency function of D w.r.t. the fuzzy 
    % $\beta$-covering subset $red$.
%     disp('-----------------2---------------------');
    DD = LMaxDD;
%     DD
    LMaxDD = MaxDD;
    
    % 6. Calculate the significance
    SIG = MaxDD - DD;
%     SIG
	
    if SIG > 0
    	flagRed(MaxDDj) = 1;
%         Red = dealingSubset(flagRed, A);
%         reduct = dealingSubset(flagRed, C);
        Red = [Red A(:,MaxDDj)];
        reduct = [reduct C(:,MaxDDj)];       
        flagB(MaxDDj) = 0;
%         B = dealingSubset(flagB, A);
    else
    	break;
    end
end

% flagRed
% Red
% reduct
save wine_FFCRS reduct class;


