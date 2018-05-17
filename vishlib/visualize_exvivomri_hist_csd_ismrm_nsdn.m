function visualize_exvivomri_hist_csd_ismrm_nsdn
    
    % Load all Data
    
    % Input signal
    load('test_set_input_b6000.mat')
    
    % Load CSD matrix and slice to dims of test size
    load('CSDmatrix.mat')
    test_CSD = CSDmatrix(49996:end,:);

    % load ISMRM data and store the predictions
    load('result_b6000_testing_10th_order.mat')
    ismrm = out_pred;
    true_hist = out_true;
    clear out_pred
    clear out_true
    
    % Load NSDN data and store the predictions
    load('result_NSDN_b6000_testing_10th_order.mat')
    nsdn = out_pred(:,133:end);
    clear out_pred
    clear out_true
    
    % Obtain the ACC of CSD and store
    csd_acc = [];
    ismrm_acc = [];
    nsdn_acc = [];
    for i=1:7272
       % Pad CSD outcome with zeros
       csd_vox = test_CSD(i,:);
       csd_vox(45:66) = 0;
       
       % Get ISMRM and NSDN voxel
       ismrm_vox = ismrm(i,:);
       nsdn_vox = nsdn(i,:);
       
       % Get true hist voxel
       true_vox = true_hist(i,:);
       
       % Get the acc values
       csd_acc_val = angularCorrCoeff(csd_vox,true_vox);
       ismrm_acc_val = angularCorrCoeff(ismrm_vox,true_vox);
       nsdn_acc_val = angularCorrCoeff(nsdn_vox,true_vox);
       
       % Store CSD acc val
       csd_acc = [csd_acc;csd_acc_val];
       ismrm_acc = [ismrm_acc;ismrm_acc_val];
       nsdn_acc = [nsdn_acc;nsdn_acc_val];
        
    end
    
    [trash_noneed,sorted_indices] = sort(csd_acc,'ascend');
    
    % Lets grab some random indices at 25th,50th and 75 percentile of the
    % sorted indices
    
    % 25th percentile, 271, 300 (good).
    low = 1837;
    % 50th percentile 3636 is good. Trials: 3700,3600,3650, 3660, 3670
    mid = 3642;
    % 75th percentile
    high = 5896;
    % 5600, 5890, 5891
    pass_this = low;
    % Lets plot some !
    xform_RAS = eye(3);
    % Input signal
    sh_raw_coeffs_1_re = reshape(test_set_input_b6000(sorted_indices(pass_this,1),:),[1 1 1 45]);
    dv_6k = dwmri_visualizer(sh_raw_coeffs_1_re, ...
                          1, ...
                          1, ...
                          xform_RAS, ...
                          'sh_coefs', ...
                          {8,120,true});
                      
    sh_raw_coeffs_2_re = reshape(true_hist(sorted_indices(pass_this,1),:),[1 1 1 66]);
    dv_hist = dwmri_visualizer(sh_raw_coeffs_2_re, ...
                          1, ...
                          1, ...
                          xform_RAS, ...
                          'sh_coefs', ...
                          {10,120,true});
                      
    sh_raw_coeffs_3_re = reshape(test_CSD(sorted_indices(pass_this,1),:),[1 1 1 45]);
    dv_csd = dwmri_visualizer(sh_raw_coeffs_3_re, ...
                          1, ...
                          1, ...
                          xform_RAS, ...
                          'sh_coefs', ...
                          {8,120,true});
                      
    sh_raw_coeffs_4_re = reshape(ismrm(sorted_indices(pass_this,1),:),[1 1 1 66]);
    dv_dl = dwmri_visualizer(sh_raw_coeffs_4_re, ...
                          1, ...
                          1, ...
                          xform_RAS, ...
                          'sh_coefs', ...
                          {10,120,true});
                      
    sh_raw_coeffs_5_re = reshape(nsdn(sorted_indices(pass_this,1),:),[1 1 1 66]);
    dv_nsdn = dwmri_visualizer(sh_raw_coeffs_5_re, ...
                          1, ...
                          1, ...
                          xform_RAS, ...
                          'sh_coefs', ...
                          {10,120,true});
                      
    figure;
    dv_6k.plot_slice(1,'axial','slice',[],subplot(1,5,1));
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('Ex-Vivo MRI')
    
    dv_hist.plot_slice(1,'axial','slice',[],subplot(1,5,2));
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('Histology - True FOD')
    
    csd_vox_acc = csd_acc(sorted_indices(pass_this,1),1);
    dv_csd.plot_slice(1,'axial','slice',[],subplot(1,5,3));
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    csd_title_name = sprintf('CSD ACC - %0.4f',csd_vox_acc);
    title(csd_title_name)
    
    dl_acc = angularCorrCoeff(sh_raw_coeffs_2_re,sh_raw_coeffs_4_re);
    dv_dl.plot_slice(1,'axial','slice',[],subplot(1,5,4));
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    dl_title_name = sprintf('DL ACC - %0.4f',dl_acc);
    title(dl_title_name)
    
    nsdn_acc = angularCorrCoeff(sh_raw_coeffs_2_re,sh_raw_coeffs_5_re);
    dv_nsdn.plot_slice(1,'axial','slice',[],subplot(1,5,5));
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    nsdn_title_name = sprintf('NSDN ACC - %0.4f',nsdn_acc);
    title(nsdn_title_name)
   
    
end