function final = Colorfulness_fd(dct)
[m,n] =size(dct);
final =sqrt(sum(sum((dct-mean2(dct)).^2)/(n*m)));
end