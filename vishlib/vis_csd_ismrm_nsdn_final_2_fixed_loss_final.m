function vis_csd_ismrm_nsdn_final_2_fixed_loss_final
    % Gets the mid left side center region of the axial slice
    % Load CSD, ISMRM, NSDN for TS04

    % Load CSD
    csd_ts04_3ta = load_untouch_nii('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS04\3TA\csd_out_3ta_jstyle.nii')
    csd_ts04_3tb = load_untouch_nii('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS04\3TB\csd_out_3tb_jstyle.nii')
    
    csd_ts04_3ta = csd_ts04_3ta.img;
    dims_1 = size(csd_ts04_3ta);
    csd_ts04_3ta = reshape(csd_ts04_3ta,[dims_1(1)*dims_1(2)*dims_1(3) 45]);
    
    csd_ts04_3tb = csd_ts04_3tb.img;
    dims_1 = size(csd_ts04_3tb);
    csd_ts04_3tb = reshape(csd_ts04_3tb,[dims_1(1)*dims_1(2)*dims_1(3) 45]);
    
    % Load ISMRM
    load('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Histo_final_no_outliers_exact_b6000_save_model\ISMRM_TS04_Test\result_scan_a.mat')
    ts4_ismrm_3ta = predicted;
    clear predicted
    
    load('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Histo_final_no_outliers_exact_b6000_save_model\ISMRM_TS04_Test\result_scan_b.mat')
    ts4_ismrm_3tb = predicted;
    clear predicted
    
    % Load NSDN predictions
    load('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Null_space_CV_MICCAI_extended_loss_fixed_final\TS04\result_NSDN_3ta.mat')
    ts4_nsdn_3ta = predicted;
    clear predicted
    load('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Null_space_CV_MICCAI_extended_loss_fixed_final\TS04\result_NSDN_3tb.mat')
    ts4_nsdn_3tb = predicted;
    clear predicted
    
    % Slash NSDN Volumes for pair outputs
    ts4_nsdn_3ta = ts4_nsdn_3ta(:,133:end);
    ts4_nsdn_3tb = ts4_nsdn_3tb(:,133:end);
    
    % Load the WM masks
    ts4_wm_mask_path = 'D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS04\T1_WM\ts04_wm_mask.nii';
    ts4_wm_mask = load_untouch_nii(ts4_wm_mask_path);
    ts4_mask = ts4_wm_mask.img;
        
    % ACC's of TS4 for CSD, ISMRM, NSDN
    [ts4_outlier_csd,ts4_csd_acc] = call_acc_vol_3d_mask(csd_ts04_3ta ,csd_ts04_3tb,ts4_mask);
    [ts4_outlier_ismrm,ts4_ismrm_acc] = call_acc_vol_3d_mask(ts4_ismrm_3ta, ts4_ismrm_3tb, ts4_mask);
    [ts4_outlier_nsdn,ts4_nsdn_acc] = call_acc_vol_3d_mask(ts4_nsdn_3ta, ts4_nsdn_3tb, ts4_mask);
    
    % Reshape all the data to volumetric format.
    csd_ts04_3ta = reshape(csd_ts04_3ta,dims_1);
    csd_ts04_3tb = reshape(csd_ts04_3tb,dims_1);
    ts4_ismrm_3ta = reshape(ts4_ismrm_3ta,[96 96 48 66]);
    ts4_ismrm_3tb = reshape(ts4_ismrm_3tb,[96 96 48 66]);
    ts4_nsdn_3ta = reshape(ts4_nsdn_3ta,[96 96 48 66]);
    ts4_nsdn_3tb = reshape(ts4_nsdn_3tb,[96 96 48 66]);
    
    % NSDN
    xform_RAS = eye(3);
    dv_single = dwmri_visualizer(ts4_nsdn_3ta, ...  
    ts4_nsdn_acc, ...
    logical(ts4_mask), ...
    xform_RAS, ...    
    'sh_coefs', ...    
    {10,60,true});
    dv_single.plot_slice(23,'axial','slice');
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('3TA NSDN')
    xlim([34.5 42.5]);ylim([22.5 30.5])
        
    xform_RAS = eye(3);
    dv_single = dwmri_visualizer(ts4_nsdn_3tb, ...  
    ts4_nsdn_acc, ...
    logical(ts4_mask), ...
    xform_RAS, ...    
    'sh_coefs', ...    
    {10,60,true});
    dv_single.plot_slice(23,'axial','slice');
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('3TB NSDN')
    xlim([34.5 42.5]);ylim([22.5 30.5])
    
    % CSD
    xform_RAS = nifti_utils.get_voxel_RAS_xform('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS04\3TA\csd_out_3ta_jstyle.nii');
    dv_single = dwmri_visualizer(csd_ts04_3ta, ...  
    ts4_csd_acc, ...
    logical(ts4_mask), ...
    xform_RAS, ...    
    'sh_coefs', ...    
    {8,60,true});
    dv_single.plot_slice(23,'axial','slice');
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('CSD 3TA')
    set(gca,'xdir','reverse')
    xlim([54.5 62.5]);ylim([22.5 30.5])
    
    xform_RAS = nifti_utils.get_voxel_RAS_xform('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS04\3TB\csd_out_3tb_jstyle.nii');
    dv_single = dwmri_visualizer(csd_ts04_3tb, ...  
    ts4_csd_acc, ...
    logical(ts4_mask), ...
    xform_RAS, ...    
    'sh_coefs', ...    
    {8,60,true});
    dv_single.plot_slice(23,'axial','slice');
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('CSD 3TB')
    set(gca,'xdir','reverse')
    xlim([54.5 62.5]);ylim([22.5 30.5])
    
    % ISMRM
    xform_RAS = eye(3);
    dv_single = dwmri_visualizer(ts4_ismrm_3ta, ...  
    ts4_ismrm_acc, ...
    logical(ts4_mask), ...
    xform_RAS, ...    
    'sh_coefs', ...    
    {10,60,true});
    dv_single.plot_slice(23,'axial','slice');
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('3TA ISMRM')
    xlim([34.5 42.5]);ylim([22.5 30.5])
    
    xform_RAS = eye(3);
    dv_single = dwmri_visualizer(ts4_ismrm_3tb, ...  
    ts4_ismrm_acc, ...
    logical(ts4_mask), ...
    xform_RAS, ...    
    'sh_coefs', ...    
    {10,60,true});
    dv_single.plot_slice(23,'axial','slice');
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('3TB ISMRM')
    xlim([34.5 42.5]);ylim([22.5 30.5])
end