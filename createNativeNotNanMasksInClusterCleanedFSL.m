function createNativeNotNanMasksInClusterCleanedFSL(sb,dirT)
%%% create non-nan mask in subject space
based = '/home/smark/';
spm_path = '/data/smark/spm';
data_path = '/data/smark/fmri_sub_preproc_dir/';
cd(based)
addpath(spm_path)


vnpar = [51,50,49,48,46,45,44,43,42,40,38:-1:34,32:-1:28,26:-1:18];
newDir = [data_path,'masks/NativeNotNanMask/',dirT];
mkdir(newDir);
fileName = [newDir,'/Sub',num2str(vnpar(sb)),'.nii'];
Im1 =[data_path,'sub', num2str(vnpar(sb)), '/stats/',dirT,'/beta_' num2str(1,'%04.0f') '.nii']; % load beta
%makeNotNanMaskIm(Im1L{10},fileName)
makeNotNanMaskIm(Im1,fileName)
