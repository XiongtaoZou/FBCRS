function Subset = dealingSubset(flagSubset, A)

n = size(flagSubset, 2);
Subset = [];
for j = 1:n
   if flagSubset(j) == 1
       Subset = [Subset A(:, j)];
   end
end

end