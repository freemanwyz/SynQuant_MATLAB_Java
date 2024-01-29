function [kMapAll, zMapAll] = synquant3d_multi_channels(datIn, noiseStd, minSz,maxSz,thrZ)
    % run each channel
    [H,W,~] = size(datIn{1});
    % xVol = cell(numel(datIn),1);
    zMapAll = zeros(H,W,3);
    kMapAll = zeros(H,W,3);
    for kk=1:numel(datIn)
        disp(kk)
        imgIn = datIn{kk};
        [kMap, zMap] = synquant3d(imgIn,noiseStd,minSz,maxSz,thrZ);
        zMapAll(:,:,kk) = zMap;
        kMapAll(:,:,kk) = kMap;
    end
end
