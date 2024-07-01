clear all
clc
tic
Coe=[0.2982    0.4439    0.028];
folder = '.\Test';%image path
%%
filepaths = dir(fullfile(folder,'*.png'));
Value=zeros(length(filepaths),1);
for ii = 1 : length(filepaths)
    disp(ii)
    I=imread(fullfile(folder,filepaths(ii).name));
    Color=Colorfulness(I);
    Con=Contrast(I);
    Sharp=UIQMSharpness(I);
    Final=Coe(1)*Color+Coe(2)*Con+Coe(3)*Sharp
    Value(ii,:)=Final;
end
toc
save('.\Value\value');
