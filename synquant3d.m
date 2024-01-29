function [kMap, zMap] = synquant3d(img,noiseStd,minSz,maxSz,thrZ)

[H1,W1,D1] = size(img);
p = paraP3D(0.05, thrZ, 0, 255, minSz, maxSz, 0.5, 4);
q = paraQ3D(1, 1, 0.8);
q.ExtendedDistance = 0;
q.zAxisMultiplier = 1;
q.curTps = 0;
q.synZscore = zeros(1,1,H1,W1);
q.var = noiseStd*noiseStd;

% detection for one channel
datx = zeros(D1,H1*W1,'uint8');
for ii=1:D1
    tmp = img(:,:,ii)';
    datx(ii,:) = tmp(:);
end

particle3D_det = ppsd3D(datx, W1, H1, 1e-6, p, q);
kMap = squeeze(particle3D_det.ppsd_main.kMap);
zMap = squeeze(particle3D_det.ppsd_main.zMap);

end

