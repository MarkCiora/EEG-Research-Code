function [xp, yp] = my_rand_perm(x,y)

w = width(y);
perm = randperm(w);

xp = x;
yp = y;
for i = 1:w
    xp(:,i) = x(:,perm(i));
    yp(:,i) = y(:,perm(i));
end

end