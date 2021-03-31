function normStructureSPM_FSL(nsb)

based = '/home/smark/fMRI_ana';
spm_path = '/data/smark/spm12';
data_path = '/data/smark/fmri_sub_preproc_dir/';
cleaned_data_path = '/data/smark/fmri_sub_preproc_dir/fsl2spmFix_BasisSetExp/sub-';
%cd(based)
addpath(spm_path)
addpath(data_path)
vnpar = [51,50,49,48,46,45,44,43,42,40,38:-1:34,32:-1:28,26:-1:18];

clear matlabbatch

matlabbatch{1}.spm.spatial.normalise.estwrite.subj.vol = cellstr(spm_select('FPList',  [cleaned_data_path,num2str(vnpar(nsb)),'\anat'], '^example_func.nii$')); % change later!

matlabbatch{1}.spm.spatial.normalise.estwrite.subj.resample = [];
%FileN = spm_select('FPList', [data_path,'Data4fsl_BasisSetExp/sub-',num2str(vnpar(nsb)),'\anat'], ['sub-',num2str(vnpar(nsb)),'_T1W.nii']);
FileN = [data_path,'Data4fsl_BasisSetExp/sub-',num2str(vnpar(nsb)),'/anat/sub-',num2str(vnpar(nsb)),'_T1W.nii'];

disp(['file: ', FileN]);
%matlabbatch{1}.spm.spatial.normalise.estwrite.subj.resample =  cellstr(spm_select('FPList', [data_path,'Data4fsl_BasisSetExp/sub-',num2str(vnpar(nsb)),'/anat'], ['sub-',num2str(vnpar(nsb)),'_T1W.nii']));
matlabbatch{1}.spm.spatial.normalise.estwrite.subj.resample =  cellstr(FileN);
disp(['file: ', cellstr(FileN)]);
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.biasreg  = 0.0001;
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.biasfwhm = 60;
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.tpm      = {fullfile(spm_path,'\tpm\TPM.nii')};
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.affreg   = 'mni';
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.reg      = [0 0.001 0.5 0.05 0.2];
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.fwhm     = 0;
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.samp     = 3;
matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.bb       = [-78 -112 -70 78 76 85];
matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.vox      = [1 1 1];
matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.interp   = 4;

spm_jobman('run', matlabbatch)


disp(['------------ NormStand Structural done ------------'])

