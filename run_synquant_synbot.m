%%
% Add SynQuant Java class into Matlab

% javaaddpath("../SynQuant-master/target/SynQuantExtra-1.2.9.jar");
javaaddpath("./libs/SynQuantExtra-1.2.9.jar");
javaaddpath("./libs/commons-math3-3.6.1.jar");
javaaddpath("./libs/ij-1.50b.jar");

minSz = 10;
maxSz = 100;
noiseStd = 20;
thrZ = 10;

dext = 10;
dextz = 0;

%%
% No ACM condition

n0 = zeros(19, 3);
for i=1:19
    f0 = strcat("../data/inhib_in_vitro_images/2019April4 - No ACM - ", num2str(i), "_oir_corrected-1.tif");
    disp(f0)
    img = read(Tiff(f0));
    dat = {img(:,:,1), img(:,:,2)};
    [~, zMapAll] = synquant3d_multi_channels(dat, noiseStd, minSz,maxSz,thrZ);
    outMap = merge_two_channels(zMapAll(:,:,1), zMapAll(:,:,2), dext, dextz);
    cc1 = bwconncomp(zMapAll(:,:,1));
    cc2 = bwconncomp(zMapAll(:,:,2));
    cc = bwconncomp(outMap);
    n0(i, 1) = cc1.NumObjects;
    n0(i, 2) = cc2.NumObjects;
    n0(i, 3) = cc.NumObjects;
end

%%
% Cx ACM condition

n1 = zeros(21, 3);
for i=1:21
    f0 = strcat("../data/inhib_in_vitro_images/2019April4 - Cx ACM - ", num2str(i), "_oir_corrected-1.tif");
    disp(f0)
    img = read(Tiff(f0));
    dat = {img(:,:,1), img(:,:,2)};
    [~, zMapAll] = synquant3d_multi_channels(dat, noiseStd, minSz,maxSz,thrZ);
    outMap = merge_two_channels(zMapAll(:,:,1), zMapAll(:,:,2), dext, dextz);
    cc1 = bwconncomp(zMapAll(:,:,1));
    cc2 = bwconncomp(zMapAll(:,:,2));
    cc = bwconncomp(outMap);
    n1(i, 1) = cc1.NumObjects;
    n1(i, 2) = cc2.NumObjects;
    n1(i, 3) = cc.NumObjects;
end

%%



