function visualize_mri_histology(voxel_num)
    close all
    %load the data
    load('input_matrix.mat')
    load('out_matrix.mat')
    load('DL_single_shell_10th_order.mat')
    load('CSDmatrix.mat')

    %voxel_num = 50;
    
    voxel_b3k_1_in = input_matrix(voxel_num,1:45);
    voxel_b6k_1_in = input_matrix(voxel_num,46:90);
    voxel_b9k_1_in = input_matrix(voxel_num,91:135);
    voxel_b12k_1_in = input_matrix(voxel_num,136:180);
    
    voxel_hist_out = out_matrix(voxel_num,:);
    voxel_dl_out = out_pred(voxel_num,:);
    voxel_csd_out = CSDmatrix(voxel_num,:);
    
    xform_RAS = eye(3);
    
    sh_raw_coeffs_1_re = reshape(voxel_b3k_1_in,[1 1 1 45]);
    dv_3k = dwmri_visualizer(sh_raw_coeffs_1_re, ...
                          1, ...
                          1, ...
                          xform_RAS, ...
                          'sh_coefs', ...
                          {8,120,true});
    
    
    sh_raw_coeffs_2_re = reshape(voxel_b6k_1_in,[1 1 1 45]);
    dv_6k = dwmri_visualizer(sh_raw_coeffs_2_re, ...
                          1, ...
                          1, ...
                          xform_RAS, ...
                          'sh_coefs', ...
                          {8,120,true});
    
                      
    sh_raw_coeffs_3_re = reshape(voxel_b9k_1_in,[1 1 1 45]);
    dv_9k = dwmri_visualizer(sh_raw_coeffs_3_re, ...
                          1, ...
                          1, ...
                          xform_RAS, ...
                          'sh_coefs', ...
                          {8,120,true});
    
                      
    sh_raw_coeffs_4_re = reshape(voxel_b12k_1_in,[1 1 1 45]);
    dv_12k = dwmri_visualizer(sh_raw_coeffs_4_re, ...
                          1, ...
                          1, ...
                          xform_RAS, ...
                          'sh_coefs', ...
                          {8,120,true});
    
                      
    sh_raw_coeffs_5_re = reshape(voxel_hist_out,[1 1 1 66]);
    dv_hist = dwmri_visualizer(sh_raw_coeffs_5_re, ...
                          1, ...
                          1, ...
                          xform_RAS, ...
                          'sh_coefs', ...
                          {10,120,true});
                      
    
    sh_raw_coeffs_6_re = reshape(voxel_dl_out,[1 1 1 66]);
    dv_dl = dwmri_visualizer(sh_raw_coeffs_6_re, ...
                          1, ...
                          1, ...
                          xform_RAS, ...
                          'sh_coefs', ...
                          {10,120,true});
                      
    
    sh_raw_coeffs_7_re = reshape(voxel_csd_out,[1 1 1 45]);
    dv_csd = dwmri_visualizer(sh_raw_coeffs_7_re, ...
                          1, ...
                          1, ...
                          xform_RAS, ...
                          'sh_coefs', ...
                          {8,120,true});
    
    figure;
    dv_3k.plot_slice(1,'axial','slice',[],subplot(2,4,1));
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('b3000')
    
    dv_6k.plot_slice(1,'axial','slice',[],subplot(2,4,2));
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('b6000')
    
    dv_9k.plot_slice(1,'axial','slice',[],subplot(2,4,3));
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('b9000')

    dv_12k.plot_slice(1,'axial','slice',[],subplot(2,4,4));
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('b12000')
    
    dv_hist.plot_slice(1,'axial','slice',[],subplot(2,4,5));
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('Histology - True FOD')
    
    dl_acc = angularCorrCoeff(sh_raw_coeffs_5_re,sh_raw_coeffs_6_re);
    dv_dl.plot_slice(1,'axial','slice',[],subplot(2,4,6));
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    dl_title_name = sprintf('Predicted - DL 10th order ACC - %0.4f',dl_acc);
    title(dl_title_name)
    
    sh_raw_coeffs_7_re(46:66) = 0;
    csd_acc = angularCorrCoeff(sh_raw_coeffs_5_re,sh_raw_coeffs_7_re);
    dv_csd.plot_slice(1,'axial','slice',[],subplot(2,4,7));
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    csd_title_name = sprintf('Predicted - CSD 8th order ACC - %0.4f',csd_acc);
    title(csd_title_name)
    
end