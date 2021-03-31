clear all
close all
clc

%%% create non-nan mask in subject space

based = 'C:\Users\smark\Documents\myExperiment\fMRInewExp\';
spm_path = 'C:\Users\smark\Desktop\spm';
data_path = 'C:\Users\smark\Documents\myExperiment\fMRInewExp\fmri_sub_preproc_dir\';
cd(based)
addpath(spm_path)

subjAll={'s46_DeCPlay','s45_WuTPlay','s44_ZiLPlay','s43_JoSPlay','s24_EBePlay','s22_ZMaPlay','s21_ZJLPlay','s20_RSePlay','s25_NSiPlay','s26_SWePlay','s28_LuPlay','s29_SVaPlay','s30_JYePlay','s18_CHuPlay','s31_ANoPlay','s32_JaCPlay','s34_BeTPlay','s35_ZaKPlay','s36_NeVPlay','s37_YiLPlay','s38_RaLPlay','s40_AnLPlay','s42_HnJPlay'};%'s38_RaLPlay','s39_AaMPlay','s40_AnLPlay','s42_HnJPlay'};%{'s39_AaMPlay','s37_YiLPlay','s36_NeVPlay','s35_ZaKPlay','s34_BeTPlay','s33_MaSPlay','s32_JaCPlay','s31_ANoPlay','s30_JYePlay','s29_SVaPlay','s25_NSiPlay','s20_RSePlay','s28_LuPlay','s26_SWePlay','s24_EBePlay','s23_MYCPlay','s22_ZMaPlay','s21_ZJLPlay','s20_RSePlay','s19_SFePlay','s18_CHuPlay'};

nSub = length(subjAll);
%subjRSA={'JoS_S43_s','EBe_S24_s','zMa_S22_s','ZJL_S21_s','RSe_S20_s','NSi_S25_s','SWe_S26_s','Lu_S28_s','SVa_S29_s','JYe_S30_s','CHu_S18_s','ANo_S31_s','JaC_S32_s','BeT_S34_s','ZaK_S35_s','NeV_S36_s','YiL_S37_s','RaL_S38_s','AnL_S40_s','HnJ_S42_s'};%,,'BeTS34_s','ZaKS35_s','NeVS36_s'};%{'AaM_S39_s','YiL_S37_s','NeVS36_s','ZaKS35_s','BeTS34_s','MaS_S33_s','JaC_S32_s','ANo_S31_s','JYe_S30_s','SVa_S29_s','NSi_S25_s','RSe_S20_s','Lu_S28_s','SWe_S26_s','EBe_S24_s','MYC_S23_s','zMa_S22_s','ZJL_S21_s','RSe_S20_s','SFe_S19_s','CHu_S18_s'};
vnpar = [46,45,44,43,24,22,21,20,25,26,28:30,18,31,32,34:38,40,42];
dirT = 'PileNregNative27_11_19';%'Pile3DistanceCorMaskB';%'allCatchIn1PileRegPaddVspNinOutClnative291019';%PileNregNative300419';%'PileNregNative140419';%%

for sb = 1:nSub
    newDir = [data_path,'masks\NativeNotNanMask\',dirT];
    mkdir(newDir);
    fileName = [newDir,'\','\Sub',num2str(vnpar(sb)),'nonNanMask.nii'];
    Im1 =[data_path,'sub', num2str(vnpar(sb)), '\stats\',dirT,'\beta_' num2str(1,'%04.0f') '.nii']; % load beta
    %Im1L =cellstr(spm_select('FPList',[data_path,'\Data\',subjAll{sb},'\s1\'], '^srf.*.nii$'));
    makeNotNanMaskIm(Im1,fileName)
     
end
