function I = SVM_indicator(w,x,b,y)
    if 1 - y*(transpose(x)*w + b) > 0
        I = 1;
    else
        I = 0;
    end
end