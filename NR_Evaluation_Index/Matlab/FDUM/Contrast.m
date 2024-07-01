function Value=Contrast(I)
    w=15;% the width of the window
    I1=double(I)/255;
    Y=ContrastDarkchannel(I1,w);%Dark channel processing
    Y1=uint8((double(Y)-min(Y(:)))/(max(Y(:))-min(Y(:)))*255);
    Contrast=Contrast_CCF(I1)*ContrastCoe(Y1);
    Value=Contrast;
end