function createNativeNotNanMasksInCluster(sb,dirT)
%%% create non-nan mask in subject space
based = '/home/smark/';
spm_path = '/data/smark/spm';
data_path = '/data/smark/fmri_sub_preproc_dir/';
cd(based)
addpath(spm_path)


vnpar = [46,45,44,43,24,22,21,20,25,26,28:30,18,31,32,34:38,40,42];
newDir = [data_path,'masks/NativeNotNanMask/',dirT];
mkdir(newDir);
fileName = [newDir,'/Sub',num2str(vnpar(sb)),'.nii'];
Im1 =[data_path,'sub', num2str(vnpar(sb)), '/stats/',dirT,'/beta_' num2str(1,'%04.0f') '.nii']; % load beta
%makeNotNanMaskIm(Im1L{10},fileName)
makeNotNanMaskIm(Im1,fileName)
