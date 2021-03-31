function save_mniSLdefinition(ROImaskN,maskN,S1,S2)

rsa_tool_path = 'rsatoolbox';
spm_path = '/data/smark/spm';
data_path = '/data/smark/fmri_sub_preproc_dir/';
surftoolbox_path = fullfile(data_path,'surfing');
addpath(genpath(fullfile(data_path,rsa_tool_path)));
addpath(spm_path);
addpath(surftoolbox_path);

MaskName = fullfile(data_path,'masks',[maskN,'.nii']);
ROIMask  = fullfile(data_path,'ROI_masks',[ROImaskN,'.nii']);
ROI         = spm_vol(ROIMask);
ROI.data    = spm_read_vols(ROI);
Mask        = spm_vol(MaskName);
Mask.data= spm_read_vols(Mask);
[L,~] = defineSearchlight_volume_Shirley(ROI,Mask,'sphere',[S1 S2]);

SL_path = fullfile(data_path,'nativeSL');
if ~exist(SL_path)
    mkdir(SL_path);
end
nameSL = ['L',num2str(S2),ROImaskN,'.mat'];
save(fullfile(SL_path,nameSL),'L');