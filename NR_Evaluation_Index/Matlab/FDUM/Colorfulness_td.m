%%%%%%%%%%
function Color_td=Colorfulness_td(I)

%%%Transform to Lab color space   
cform = makecform('srgb2lab');
Img_lab = applycform(I, cform);

Img_a=double(Img_lab(:,:,2))./255;
Img_b=double(Img_lab(:,:,3))./255;
%%%% Chroma   
Img_Chr=sqrt(Img_a(:).^2+Img_b(:).^2);

%% Average of Chroma       
Aver_Chr=mean(Img_Chr);
%%% Variance of Chroma       
Color_td =sqrt(mean((abs(1-(Aver_Chr./Img_Chr).^2))));