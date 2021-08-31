%%%%%%%%%%%%%%%%%Zhang-TFS2020%%%%%%%%%%%%%%%

clc; clear; close all;

X = [0.89 0.77 0.69
     0.88 0.85 0.78
     0.79 0.67 0.93
     0.56 0.84 0.63];

Beta = 0.74;

% X = X(:,1);  %%%%%test%%%%%
% Beta = 0.5;
% mBeta = maxBeta(X);
% mBeta

%%%%%%%%%%%%%Fuzzy $beta$-neighborhood operator%%%%%%%%%%
FBN = ReflexiveFBNO(X, Beta);
FBN

%%%%%%%%%%%%%the upper and lower approximations of fuzzy sets F%%%%%%%%%%%%
F = [0.58 0.65 0.77 0.76];
[m, n] = size(X);
Cu = zeros(m);	% �Ͻ����м�ֵ
Cl = zeros(m);	% �½����м�ֵ
for i = 1:m
    Cu(i,:) = max(0, FBN(i,:) + F - 1);
    Cl(i,:) = min(1, 1 - FBN(i,:) + F);
end
CFu = max(Cu');  % �Ͻ���
CFl = min(Cl');  % �½���
C = [CFu; CFl];
C
