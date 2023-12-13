# Call SynQuant from MATLAB
This repository provides a toy example showing how to call SynQuant from MATLAB. 
This example is especially useful if you want to batch-process a large number of images.
The demo can be found in "demo_synquant_java.m". More details can be found there.
Also check "demo_synquant_java_two_channels.m", if you want to work with two channels.

The Java classes are extracted and modified from the SynQuant Fiji plugin (https://github.com/yu-lab-vt/SynQuant).

Some Fiji version functionalities are not tested or included:
1. Noise estimation.
2. Support for more than two channels.
3. Support for dendrite detection and quantification
4. Support for GUI.
5. Some post-processing steps, such as filtering by aspect ratio.
6. Split clustered synapses.

Some newly added functions of SynQuant may not be included.
