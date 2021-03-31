function createVsearchLight2ClusterCorrect(sb,areaM,ROImask,WB,dirT)

based = '/home/smark';%/fMRI_ana';
spm_path = '/data/smark/spm';
data_path = '/data/smark/fmri_sub_preproc_dir/';
rsa_tool_path = 'rsatoolbox';
addpath(genpath(fullfile(data_path,rsa_tool_path)))
surftoolbox_path = [data_path,'surfing'];
addpath(based)
addpath(spm_path)
addpath(surftoolbox_path)

%%participants:
%subjAll={'s43_JoSPlay','s24_EBePlay','s22_ZMaPlay','s21_ZJLPlay','s20_RSePlay','s25_NSiPlay','s26_SWePlay','s28_LuPlay','s29_SVaPlay','s30_JYePlay','s18_CHuPlay','s31_ANoPlay','s32_JaCPlay','s34_BeTPlay','s35_ZaKPlay','s36_NeVPlay','s37_YiLPlay','s38_RaLPlay','s40_AnLPlay','s42_HnJPlay'};%'s38_RaLPlay','s39_AaMPlay','s40_AnLPlay','s42_HnJPlay'};%{'s39_AaMPlay','s37_YiLPlay','s36_NeVPlay','s35_ZaKPlay','s34_BeTPlay','s33_MaSPlay','s32_JaCPlay','s31_ANoPlay','s30_JYePlay','s29_SVaPlay','s25_NSiPlay','s20_RSePlay','s28_LuPlay','s26_SWePlay','s24_EBePlay','s23_MYCPlay','s22_ZMaPlay','s21_ZJLPlay','s20_RSePlay','s19_SFePlay','s18_CHuPlay'};
% subjRSA={'JoS_S43_s','EBe_S24_s','zMa_S22_s','ZJL_S21_s','RSe_S20_s','NSi_S25_s','SWe_S26_s','Lu_S28_s','SVa_S29_s','JYe_S30_s','CHu_S18_s','ANo_S31_s','JaC_S32_s','BeT_S34_s','ZaK_S35_s','NeV_S36_s','YiL_S37_s','RaL_S38_s','AnL_S40_s','HnJ_S42_s'};%,,'BeTS34_s','ZaKS35_s','NeVS36_s'};%{'AaM_S39_s','YiL_S37_s','NeVS36_s','ZaKS35_s','BeTS34_s','MaS_S33_s','JaC_S32_s','ANo_S31_s','JYe_S30_s','SVa_S29_s','NSi_S25_s','RSe_S20_s','Lu_S28_s','SWe_S26_s','EBe_S24_s','MYC_S23_s','zMa_S22_s','ZJL_S21_s','RSe_S20_s','SFe_S19_s','CHu_S18_s'};
vnpar = [46,45,44,43,24,22,21,20,25,26,28:30,18,31,32,34:38,40,42];

%%name of ROI masks:
%areaM = 'wholeBrainM';%'IIT_MeanT1_2x2x2';%'FrontalTemporalHippoMask';%'temporalLobeHippocampuseEC';%'HippocampusMask2';%'HippocampuseEC';%
%ROImask = 'oStMask.nii';%[areaM,'.nii'];
%WB = 1;
%[data_path,'/s',vnpar(nsb),'/nativeStMask/'],'oStMask.nii$'

tic
%% read ROI mask:
if ~isempty(ROImask)
    if WB==1
        nameMaskROI = [data_path,'nativeStMask/s',num2str(vnpar(sb)),'/',ROImask];
    else
        nameMaskROI = [data_path,'/masks/oG',num2str(vnpar(sb)),ROImask];
    end
    ROI         = spm_vol(nameMaskROI);
    ROI.data    = spm_read_vols(ROI);
else
    ROI = [];
end

nameNanMask = [data_path,'/masks/NativeNotNanMask/',dirT,'/Sub',num2str(vnpar(sb)),'nonNanMask.nii'];
%nameNanMask = [data_path,'masks/NativeNotNanMask/',dirT,'/Sub',num2str(vnpar(sb)),'.nii'];

% nameNanMask = [based,'\fmri_sub_preproc_dir\masks\nativeNotNanMaskSub',num2str(vnpar(sb)),'300419betas.nii'];
nanMask     = spm_vol(nameNanMask);
nanMask.data= spm_read_vols(nanMask);

disp(['is ROI empty? ', num2str(1*isempty(ROI))])
disp(['is nanMask empty? ', num2str(1*isempty(nanMask))])

subDir = [data_path,'sub',num2str(vnpar(sb))];
[L,~] = defineSearchlight_volume_forParal(vnpar(sb),subDir,ROI,nanMask,'sphere',[100 200]);
cd(based)
disp(pwd)
%L           = rsa.defineSearchlight_volume(ROI,nanMask,'sphere',[70 200]);%[70 216]);%
% L           = rsa.defineSearchlight_volume(ROI,nanMask);

nameDir = [data_path,'/NativeSearchLightDefinitions/',areaM,'/',dirT,'/s',num2str(vnpar(sb))];
mkdir(nameDir);
%save([nameDir,'Ldefault.mat'],'L');
save([nameDir,'/L200_271219.mat'],'L');
disp(['subject ',num2str(sb),' done search light defitions'])
toc

