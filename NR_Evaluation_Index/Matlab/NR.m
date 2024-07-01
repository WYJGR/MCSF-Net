clc


addpath("CCF\","CEIQ\","FADE\","FDUM\","NIQMC\")
addpath("CEIQ\data\","CEIQ\images\","CEIQ\utils\")
 
sixNR('image folder path','folder name')




%%
function sixNR(folderPath,setName)  
    Coe=[0.2982    0.4439    0.028];
    % 获取文件夹中的所有文件  
    files = dir(fullfile(folderPath, '*.*'));
    for i = 3:length(files)
%         disp(i);
        imagepath=fullfile(folderPath, files(i).name);
        im = imread(imagepath);
        im = imresize(im, [350 350]);
        BRISQUE(i-2)= brisque(im);
        CEIQs(i-2) = CEIQ(im);
        CCFs(i-2) = CCF(im);
        FDUMs(i-2) = Coe(1)*Colorfulness(im)+Coe(2)*Contrast(im)+Coe(3)*UIQMSharpness(im);
        NIQMCs(i-2) = NIQMC(im); 
        FADEs(i-2) = FADE(im);
    end
    B = [mean(BRISQUE), mean(CEIQs), mean(CCFs), mean(FDUMs), mean(NIQMCs), mean(FADEs)];      
    fid = fopen('result.txt', 'a+'); 
    fprintf(fid,"%s ",setName);
    fprintf(fid, '%.4f %.4f %.4f %.4f %.4f %.4f\n', B.');     
    fclose(fid);
end