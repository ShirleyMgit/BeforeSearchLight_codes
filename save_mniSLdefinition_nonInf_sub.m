function save_mniSLdefinition_nonInf_sub(sb,ROImaskN,S1,S2)

vnpar = [51,50,49,48,46,45,44,43,42,40,38:-1:34,32:-1:28,26:-1:24,22:-1:18];
rsa_tool_path = 'rsatoolbox';
spm_path = '/data/smark/spm';
data_path = '/data/smark/fmri_sub_preproc_dir/';
surftoolbox_path = fullfile(data_path,'surfing');
addpath(genpath(fullfile(data_path,rsa_tool_path)));
addpath(spm_path);
addpath(surftoolbox_path);
mask_path = fullfile(data_path,'masks','mniNotNanMask_cleaned');
MaskName = fullfile(mask_path ,['notInf_Sub',num2str(vnpar(sb)),'.nii']);
ROIMask  = fullfile(data_path,'ROI_masks',[ROImaskN,'.nii']);
ROI         = spm_vol(ROIMask);
ROI.data    = spm_read_vols(ROI);
Mask        = spm_vol(MaskName);
Mask.data= spm_read_vols(Mask);
[L,~] = defineSearchlight_volume_Shirley(ROI,Mask,'sphere',[S1 S2]);

SL_pathAll = fullfile(data_path,'mni_SL');
if ~exist(SL_pathAll)
    mkdir(SL_pathAll);
end
SL_path = fullfile(SL_pathAll,['sub',num2str(vnpar(sb))]);
if ~exist(SL_path)
    mkdir(SL_path);
end
nameSL = ['L',num2str(S2),ROImaskN,'nonInfCorrect.mat'];
save(fullfile(SL_path,nameSL),'L');