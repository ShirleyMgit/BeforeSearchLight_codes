function createMNI_NotNanNotInfMasksInClusterCleanedFSL(sb)
%%% create non-nan non-inf mask in subject space
based = '/home/smark/';
spm_path = '/data/smark/spm';
data_path = '/data/smark/fmri_sub_preproc_dir/';
cleaned_data_path = '/data/smark/fmri_sub_preproc_dir/fsl2spmFix_BasisSetExp/';
cd(based)
addpath(spm_path)


vnpar = [51,50,49,48,46,45,44,43,42,40,38:-1:34,32:-1:28,26:-1:24,22:-1:18];
newDir = fullfile(data_path,'masks','mniNotNanMask_cleaned');
if exist(newDir,'dir')==0
    mkdir(newDir);
end
fileName = [newDir,'/Sub',num2str(vnpar(sb)),'.nii'];
fileName2 = [newDir,'/notInf_Sub',num2str(vnpar(sb)),'.nii'];
% fileName2 = [newDir,'/nonInfNonNan_Sub',num2str(vnpar(sb)),'.nii'];
% if exist(fileName2,'file')~=0
%     delete(fileName2);
%     disp([fileName2, ' has been deleted']);
% end
Im1 = fullfile(cleaned_data_path,['sub-',num2str(vnpar(sb))],'sess01', ['mni_',num2str(vnpar(sb)),'r_cleaned_smoothed_0100.nii']);
disp(Im1);
%Im1 =[data_path,'sub', num2str(vnpar(sb)), '/stats/',dirT,'/beta_' num2str(1,'%04.0f') '.nii']; % load beta
%makeNotNanMaskIm(Im1L{10},fileName)
makeNotNanMaskIm(Im1,fileName)
makeNotInfMaskImNew(fileName,fileName2);%changed on the 200920