function [zMap,zLst,pixLst] = synquant_3d_single(img,xstd,minSz,maxSz)

[H1,W1,D1] = size(img);

q = paraQ3D();
q.thrZ = 2;
q.var = xstd^2;
q.Nx = W1; q.Ny = H1; q.Nz = D1;
q.minVal = 10;
q.maxVal = 255;
q.MinSize = minSz;
q.MaxSize = maxSz;

% detection for one channel
datx = zeros(D1,H1*W1,'uint8');
for ii=1:D1
    tmp = img(:,:,ii)';
    datx(ii,:) = tmp(:);
end
x = ppsdRun();
x.run3D(datx,q);
res = x.synMap3D;
zMap = x.z3D;

% clean output z-map
ccDet = bwconncomp(res>0);
zLst = zeros(ccDet.NumObjects,1);
pixLst = ccDet.PixelIdxList';
for ii=1:ccDet.NumObjects
    z0 = mean(zMap(ccDet.PixelIdxList{ii}));
    zMap(ccDet.PixelIdxList{ii}) = z0;
    zLst(ii) = z0;
end
zMap(res==0) = 0;

end

