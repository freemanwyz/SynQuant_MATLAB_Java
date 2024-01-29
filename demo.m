%%
% Add SynQuant Java class into Matlab

javaaddpath("./libs/SynQuantExtra-1.2.9.jar");
javaaddpath("./libs/commons-math3-3.6.1.jar");
javaaddpath("./libs/ij-1.50b.jar");


%%
% Read data

f0 = "./example/example synapse.tif";
obj = Tiff(f0);
img = read(obj);
dat = double(img);

figure
imshow(img)

%%
minSz = 5;  % minimum size of puncta in pixels
maxSz = 100;  % maximum size of puncta in pixels
noiseStd = 10;  % noise level, images are scaled to [0, 255]
thrZ = 5;  % z-score threshold, typically 5 or 10

% k0 is the map for puncta index
% z0 is hte z-score map of puncta
[k0, z0] = synquant3d(img, noiseStd, minSz, maxSz, thrZ);


%%

figure;
imshow(z0)


