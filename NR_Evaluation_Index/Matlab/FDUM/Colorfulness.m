function Value=Colorfulness(I)
    X=rgb2gray(I);
    Y=dct2(X);
    Y1=uint8(Y);
    Colorfulness=Colorfulness_fd(Y1)*Colorfulness_td(I);
    Value=Colorfulness;
end

