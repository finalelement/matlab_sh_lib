function visualize_csd_invivo_slice

    sh_coefs_vol = load_untouch_nii('FOD_SH.nii');
    sh_vol = sh_coefs_vol.img;
    for i = 1:size(sh_vol,1)
       for j = 1:size(sh_vol,2)
           for k = 1:size(sh_vol,3)
               sh_vol(i,j,k,:) = sh_mrtrix2matlab(sh_vol(i,j,k,:),8);
           end
       end
    end
    
    % Load FA
    nifti_fa = load_untouch_nii('vishabyte_b2000_fa.nii');
    fa = nifti_fa.img;
    
    % Load mask
    nifti_mask = load_untouch_nii('global_mask_mask.nii');
    mask = logical(nifti_mask.img);
    
    xform_RAS = eye(3);
    
    dv = dwmri_visualizer(sh_vol, ...
                      fa(:,:,:), ... 
                      mask, ...
                      xform_RAS, ...
                      'sh_coefs', ...
                      {8,45,false});

    % Make a plot
    %dv.plot_slice(47,'coronal','slice');
    dv.plot_slice(40,'axial','slice');
    axis image
    light('Position', [5, 5, 5], 'Style', 'infinite')
end