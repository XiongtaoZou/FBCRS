function mbeta = maxBeta(A)

n = size(A, 2);
if n == 1
    mbeta = min(A);
else
    mbeta = min(max(A'));
end

end