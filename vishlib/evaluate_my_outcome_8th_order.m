function evaluate_my_outcome_8th_order(voxel_num)
    %close all
    figure
    load('my_outcome_testing_8th_order.mat')
    
    true_voxel = out_true(voxel_num,1:45);
    pred_voxel = out_pred(voxel_num,1:45);
    
    xform_RAS = eye(3);
    
    % True Voxel
    sh_true_coeffs = reshape(true_voxel,[1 1 1 45]);
    dv_true = dwmri_visualizer(sh_true_coeffs, ...
                          1, ...
                          1, ...
                          xform_RAS, ...
                          'sh_coefs', ...
                          {8,120,true});
                      
    % Predicted Voxel
    sh_pred_coeffs = reshape(pred_voxel,[1 1 1 45]);
    dv_pred = dwmri_visualizer(sh_pred_coeffs, ...
                          1, ...
                          1, ...
                          xform_RAS, ...
                          'sh_coefs', ...
                          {8,120,true});
    
    dv_true.plot_slice(1,'axial','slice',[],subplot(1,2,1));
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('True Voxel - 8th order')
    
    dv_pred.plot_slice(1,'axial','slice',[],subplot(1,2,2));
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('Predicted Voxel - 8th order')

end