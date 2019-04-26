image_path = "E:\Program_new\Feature_map\patient_1_wavelet-LLH_glcm_Autocorrelation.nrrd";
s = load(image_path);
a = nrrdread(image_path);
mriVolumeOriginal = squeeze(s.D);
sizeO = size(mriVolumeOriginal);