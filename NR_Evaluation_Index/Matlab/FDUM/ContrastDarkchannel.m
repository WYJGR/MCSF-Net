function I=ContrastDarkchannel(I1,w)
    r=I1(:,:,1);g=I1(:,:,2);b=I1(:,:,3);
    [m,n]=size(r);
    I2=zeros(m,n);
    for i=1:m
        for j=1:n
            save_data=min(r(i,j),g(i,j));
            save_data=min(b(i,j),save_data);
            I2(i,j)=save_data;
        end
    end
    I=zeros(m-w,n-w);
    for i=1:m-w
        for j=1:n-w
            I(i,j)=min(min(I2(i:i+w-1,j:j+w-1)));
        end
    end
end