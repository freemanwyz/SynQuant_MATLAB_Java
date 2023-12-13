%%
% Add SynQuant Java class into Matlab

add_java_path('add')

%% 
% Generate toy image and add noise
% The image should be scaled to be between 0 to 1

dat = zeros(128, 128)+0.2;
for i=1:11
    for j=1:11
        dat(i*10:i*10+5, j*10:j*10+5) = 0.7;
    end
end
dat_noisy = dat + randn(128,128)*0.1;

figure
imshow(dat)

figure
imshow(dat_noisy)

% the first one is assumed to be pre-synaptic, the second post-synaptic
dat_two_channel = {dat_noisy, dat_noisy};

%%
% A naive noise estimation method
%
% SynQuant need an estimated noise standard deviation. 
% A more sophisticated version is implemented in the Fiji plug-in,
% but that method is not always robust.
% You can also choose any exisint single image noise estimation method.
%
% This naive method compare a pixel with its neighbor to estimate noise.
% For smmothed images, choose a larger gap value.

gap = 1;
dif = dat_noisy(:, 1+gap:end) - dat_noisy(:,1:end-gap);
dif2 = dif.*dif;
noise_estimated = sqrt(median(dif2(:)));
disp(noise_estimated)

%%
% Run SynQuant on two channels
% You need to provide minimum synapse size (here 10), and maximum size (here 50)
%
% Outputs:
%
% out_overall: the map for the combined synapse
% res_per_channel: SynQuant results for each channel

[out_overall, res_per_channel] = synquant_3d_two_channels(dat_two_channel, noise_estimated, 10, 50);

% pixel or voxel list for each combined synapse
pixLst = bwconncomp(out_overall);

figure
imshow(out_overall)


