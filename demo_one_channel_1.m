%%
% Add SynQuant Java class into Matlab

% javaaddpath("../SynQuant-master/target/SynQuantExtra-1.2.9.jar");
javaaddpath("./libs/SynQuantExtra-1.2.9.jar");
javaaddpath("./libs/commons-math3-3.6.1.jar");
javaaddpath("./libs/ij-1.50b.jar");


%%
% Read data

f0 = "../data/2019April4 - Cx ACM - 1_oir_corrected-1.tif (green).tif";
% f0 = "../data/2019April4 - Cx ACM - 1_oir_corrected-1.tif (red).tif";
obj = Tiff(f0);
img = read(obj);
dat = double(img);
figure
imshow(img)

%%
minSz = 10;
maxSz = 100;
noiseStd = 20;
thrZ = 10;

[k0, z0] = synquant3d(img, noiseStd, minSz, maxSz, thrZ);

%%

