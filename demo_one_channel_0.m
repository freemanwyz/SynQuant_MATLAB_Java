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
% construct SynQuant Java objects

minSz = 10;
maxSz = 100;
noiseStd = 20;
zThr = 10;

[H1,W1,D1] = size(img);
p = paraP3D(0.05, zThr, 0, 255, minSz, maxSz, 0.5, 4);
q = paraQ3D(1, 1, 0.8);
q.ExtendedDistance = 0;
q.zAxisMultiplier = 1;
q.curTps = 0;
q.synZscore = zeros(1,1,H1,W1);
q.var = noiseStd*noiseStd;

% Reshape input image for SynQuant
datx = zeros(D1,H1*W1,'uint8');
for ii=1:D1
    tmp = img(:,:,ii)';
    datx(ii,:) = tmp(:);
end

% detection for one channel
particle3D_det = ppsd3D(datx, W1, H1, 1e-6, p, q);
k0 = squeeze(particle3D_det.ppsd_main.kMap);
z0 = squeeze(particle3D_det.ppsd_main.zMap);

%%




