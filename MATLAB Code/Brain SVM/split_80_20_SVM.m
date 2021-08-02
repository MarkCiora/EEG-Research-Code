function s = split_80_20_SVM(x,y,size)
    s(1).x = x(:,1:round(size/5),:);
    s(1).y = y(:,1:round(size/5),:);
    
    s(2).x = x(:,1+round(size/5):round(2*size/5),:);
    s(2).y = y(:,1+round(size/5):round(2*size/5),:);
    
    s(3).x = x(:,1+round(2*size/5):round(3*size/5),:);
    s(3).y = y(:,1+round(2*size/5):round(3*size/5),:);
    
    s(4).x = x(:,1+round(3*size/5):round(4*size/5),:);
    s(4).y = y(:,1+round(3*size/5):round(4*size/5),:);
    
    s(5).x = x(:,1+round(4*size/5):size,:);
    s(5).y = y(:,1+round(4*size/5):size,:);
    
end