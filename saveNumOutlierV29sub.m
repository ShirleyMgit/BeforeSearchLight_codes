function saveNumOutlierV29sub(subN,isPC,nuisanceDir)
% This function save a nusance regressors, with and without derivatives
% nuisanceDir variable were added on the 5/9/20 (Shirley)

vnpar = [51,50,49,48,46,45,44,43,42,40,38:-1:34,32:-1:28,26:-1:18];
Voutliers = zeros(1,4);
for ses=1:4
    if isPC==1
        dir0 = ['D:\fMRInewExp\fsl2spmFix_BasisSetExp\sub-',num2str(vnpar(subN)),'\sess0',num2str(ses),'\'];
    else
        dir0 = fullfile('/data','smark','fmri_sub_preproc_dir','Data4fsl_BasisSetExp','derivatives',['sub-',num2str(vnpar(subN))],'func',['ses-0',num2str(ses)]);
    end
   
    motionOutliers = load(fullfile(dir0,nuisanceDir,'motionOutliers.txt'));
    Voutliers(ses) = length(motionOutliers);
    disp(['done ses ', num2str(ses)])
end
dir1 = fullfile('/data','smark','fmri_sub_preproc_dir','Data4fsl_BasisSetExp','derivatives',['sub-',num2str(vnpar(subN))]);
save([dir1,'/Voutliers.mat'],'Voutliers');
disp(['done subject ', num2str(vnpar(subN))]);