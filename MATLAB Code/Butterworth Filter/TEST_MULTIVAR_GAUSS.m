%% 2 variable gaussian dist
clc
clear
mean(:,:,1) = [1;2]
mean(:,:,2) = [-1;0]
mean(:,:,3) = [3;-1]
cov(:,:,1) = [1 .5;1 2]
cov(:,:,2) = [1 .5;1 2]
cov(:,:,3) = [1 .5;1 2]

asdf=.1
x = (-40:40)*asdf;
y = (-40:40)*asdf;

const(1) = (1/(2*pi*sqrt(det(cov(:,:,1)))));
const(2) = (1/(2*pi*sqrt(det(cov(:,:,2)))));
const(3) = (1/(2*pi*sqrt(det(cov(:,:,3)))));

for i = 1:81
    for j = 1:81
        out1(i,j) = const(1).*exp(-(1/2)*transpose([x(i);y(j)]-mean(:,:,1))/cov(:,:,1)*([x(i);y(j)]-mean(:,:,1)));
    end
end

for i = 1:81
    for j = 1:81
        out2(i,j) = const(2).*exp(-(1/2)*transpose([x(i);y(j)]-mean(:,:,2))/cov(:,:,2)*([x(i);y(j)]-mean(:,:,2)));
    end
end

for i = 1:81
    for j = 1:81
        out3(i,j) = const(2).*exp(-(1/2)*transpose([x(i);y(j)]-mean(:,:,3))/cov(:,:,3)*([x(i);y(j)]-mean(:,:,3)));
    end
end


mesh(out1)
hold on
mesh(out2)
mesh(out3)
title('both individually')

figure(2)
out = out1+out2+out3;
mesh(out)
title('both summed')

prop1 = out1./out;
prop2 = out2./out;
prop3 = out3./out;

figure(3)
mesh(prop1,zeros(81)+1)
hold on
mesh(prop2,zeros(81))
mesh(prop3,zeros(81) + 2)