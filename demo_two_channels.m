%%
% Add SynQuant Java class into Matlab

% javaaddpath("../SynQuant-master/target/SynQuantExtra-1.2.9.jar");
javaaddpath("./libs/SynQuantExtra-1.2.9.jar");
javaaddpath("./libs/commons-math3-3.6.1.jar");
javaaddpath("./libs/ij-1.50b.jar");


%%
% Read a image with two channels

f0 = "../data/inhib_in_vitro_images/2019April4 - No ACM - 7_oir_corrected-1.tif";
% f0 = "../data/inhib_in_vitro_images/2019April4 - Cx ACM - 7_oir_corrected-1.tif";

obj = Tiff(f0);
img = read(obj);
dat0 = img(:,:,1);  % considered as pre-synaptic
dat1 = img(:,:,2);  % considered as post-synaptic
dat = {dat0, dat1};

figure
imshow(img)


%%
% Run detection

minSz = 10;
maxSz = 100;
noiseStd = 20;
thrZ = 10;

[kMapAll, zMapAll] = synquant3d_multi_channels(dat, noiseStd, minSz,maxSz,thrZ);


%%
% Merge twoi channels to find co-localized puncta

dext = 10;  % extend in xy direction, in pixels, to find partner
dextz = 0;  % extend in z-direction
outMap = merge_two_channels(zMapAll(:,:,1), zMapAll(:,:,2), dext, dextz);

figure;
imshow(outMap)

% count the number of puncta
cc1 = bwconncomp(zMapAll(:,:,1));
cc2 = bwconncomp(zMapAll(:,:,2));
cc = bwconncomp(outMap);



