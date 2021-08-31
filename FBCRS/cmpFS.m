function ret = cmpFS(A,B)

m = size(A,1);
cnt=0;
for i=1:m
   if A(i,:) >= B(i,:)
       cnt=cnt+1;
   end   
end

if cnt==m
    ret = 1;
else
    ret=0;
end

end