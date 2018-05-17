function evaluate_my_outcome_10th_order_invivo(voxel_num)
    %close all
    figure
    load('result_invivo_vish_b2000.mat')
    load('testing_invivo_vish.mat')
    
    true_voxel = invivo_vish(voxel_num,1:45);
    pred_voxel = out_pred(voxel_num,1:66);
    
    xform_RAS = eye(3);
    
    % Input signal
    sh_true_coeffs = reshape(true_voxel,[1 1 1 45]);
    dv_true = dwmri_visualizer(sh_true_coeffs, ...
                         1, ...
                         1, ...
                         xform_RAS, ...
                         'sh_coefs', ...
                         {8,120,true});
                      
    % Predicted Voxel
    sh_pred_coeffs = reshape(pred_voxel,[1 1 1 66]);
    dv_pred = dwmri_visualizer(sh_pred_coeffs, ...
                          1, ...
                          1, ...
                          xform_RAS, ...
                          'sh_coefs', ...
                          {10,120,true});
    
    dv_true.plot_slice(1,'axial','slice',[],subplot(1,2,1));
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('Input Signal - 8th order')
    
    dv_pred.plot_slice(1,'axial','slice',[],subplot(1,2,2));
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('Predicted Voxel - 10th order')

end