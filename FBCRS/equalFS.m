function ret = equalFS(A, B)

if sum(A == B) == size(A, 2)
    ret = 1;
else
    ret = 0;
end

end

% function ret = nequalFS(A, B)
% ret = 0;
% n = size(A, 2);
% for i = 1:n
%     if A(i) ~= B(i)
%         ret = 1;
%         break;
%     end
% end
% end
