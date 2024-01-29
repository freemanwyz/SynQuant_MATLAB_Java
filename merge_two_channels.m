function outMap = merge_two_channels(x1, x2, dext, dextz)
% % update the score for each post-synaptic puncta
% dext = 0;  % search in XY
% dextz = 0;  % search in Z

cc = bwconncomp(x2);
sLst = cc.PixelIdxList;  % check each post puncta
postVol = x2;
preVol = x1;

[H1,W1,D1] = size(x1);
outMap = zeros(H1,W1,D1);
for ii=1:numel(sLst)
    s0 = sLst{ii};
    [h0,w0,d0] = ind2sub([H1,W1,D1],s0);
    zPost = mean(postVol(s0));
    
    % find highest pre puncta score
    zPre = 0;
    for jj=1:numel(h0)
        h00 = h0(jj); w00 = w0(jj); d00 = d0(jj);
        hrg = max(h00-dext,1):min(h00+dext,H1);
        wrg = max(w00-dext,1):min(w00+dext,W1);
        drg = max(d00-dextz,1):min(d00+dextz,D1);
        preVolCrop = preVol(hrg,wrg,drg);
        zPre = max(max(preVolCrop(:)),zPre);
    end
    
    % combine scores
    outMap(s0) = zPost*zPre;
end

end

