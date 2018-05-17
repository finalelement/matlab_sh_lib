function visualize_invivo_slice
    load('result_vol_invivo_vish_b2000.mat')
    output_vol = reshape(out_pred,[78 93 75 66]);
    
    % Load mask
    nifti_mask = load_untouch_nii('global_mask_mask.nii');
    mask = logical(nifti_mask.img);
    
    % Load FA
    nifti_fa = load_untouch_nii('vishabyte_b2000_fa.nii');
    fa = nifti_fa.img;
    
    xform_RAS = eye(3);
    
    dv = dwmri_visualizer(output_vol, ...
                      fa(:,:,:), ... 
                      mask, ...
                      xform_RAS, ...
                      'sh_coefs', ...
                      {10,66,false});

    % Make a plot
    %dv.plot_slice(47,'coronal','slice');
    dv.plot_slice(40,'axial','slice');
    axis image
    light('Position', [5, 5, 5], 'Style', 'infinite')

end