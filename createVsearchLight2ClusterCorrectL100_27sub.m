function createVsearchLight2ClusterCorrectL100_27sub(sb,areaM,ROImask,WB,dirT)

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
vnpar = [50,49,48,46,45,44,43,42,40,38:-1:34,32:-1:28,26:-1:24,22:-1:18];

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

%nameNanMask = [data_path,'/masks/NativeNotNanMask/',dirT,'/Sub',num2str(vnpar(sb)),'nonNanMask.nii'];
nameNanMask = [data_path,'masks/NativeNotNanMask/',dirT,'/Sub',num2str(vnpar(sb)),'.nii'];

% nameNanMask = [based,'\fmri_sub_preproc_dir\masks\nativeNotNanMaskSub',num2str(vnpar(sb)),'300419betas.nii'];
nanMask     = spm_vol(nameNanMask);
nanMask.data= spm_read_vols(nanMask);

disp(['is ROI empty? ', num2str(1*isempty(ROI))])
disp(['is nanMask empty? ', num2str(1*isempty(nanMask))])

subDir = [data_path,'sub',num2str(vnpar(sb))];
[L,~] = defineSearchlight_volume_forParal(vnpar(sb),subDir,ROI,nanMask,'sphere',[70 100]);
cd(based)
disp(pwd)
%L           = rsa.defineSearchlight_volume(ROI,nanMask,'sphere',[70 200]);%[70 216]);%
% L           = rsa.defineSearchlight_volume(ROI,nanMask);

nameDir = [data_path,'/NativeSearchLightDefinitions/',areaM,'/',dirT,'/s',num2str(vnpar(sb))];
mkdir(nameDir);
%save([nameDir,'Ldefault.mat'],'L');
save([nameDir,'/L100_280220.mat'],'L');
disp(['subject ',num2str(sb),' done search light defitions'])
toc

